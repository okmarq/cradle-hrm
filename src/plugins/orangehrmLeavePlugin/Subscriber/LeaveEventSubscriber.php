<?php

/**
 * OrangeHRM is a comprehensive Human Resource Management (HRM) System that captures
 * all the essential functionalities required for any enterprise.
 * Copyright (C) 2006 OrangeHRM Inc., http://www.orangehrm.com
 *
 * OrangeHRM is free software; you can redistribute it and/or modify it under the terms of
 * the GNU General Public License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * OrangeHRM is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along with this program;
 * if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA  02110-1301, USA
 */

namespace OrangeHRM\Leave\Subscriber;

use CradleHRM\Services\MailService;
use InvalidArgumentException;
use OrangeHRM\Core\Service\EmailService;
use OrangeHRM\Leave\Event\LeaveAllocate;
use OrangeHRM\Leave\Event\LeaveApplyEvent;
use OrangeHRM\Leave\Event\LeaveApply;
use OrangeHRM\Leave\Event\LeaveApprove;
use OrangeHRM\Leave\Event\LeaveAssign;
use OrangeHRM\Leave\Event\LeaveCancel;
use OrangeHRM\Leave\Event\LeaveEvent;
use OrangeHRM\Leave\Event\LeaveReject;
use OrangeHRM\Leave\Event\LeaveStatusChange;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class LeaveEventSubscriber implements EventSubscriberInterface
{
    private ?EmailService $emailService = null;
    private ?MailService $mailService = null;

    /**
     * @inheritDoc
     */
    public static function getSubscribedEvents(): array
    {
        return [
            LeaveApplyEvent::APPLY => [['emailPerformer', 0], ['emailSupervisor', 0]],
            LeaveEvent::APPLY => [['onAllocateEvent', 0]],
            LeaveEvent::APPLY => [['onAllocateEvent', 0]],
            LeaveEvent::ASSIGN => [['onAllocateEvent', 0]],
            LeaveEvent::APPROVE => [['onStatusChangeEvent', 0]],
            LeaveEvent::CANCEL => [['onStatusChangeEvent', 0]],
            LeaveEvent::REJECT => [['onStatusChangeEvent', 0]],
        ];
    }

    /**
     * @return EmailService
     */
    public function getEmailService(): EmailService
    {
        if (!$this->emailService instanceof EmailService) {
            $this->emailService = new EmailService();
        }
        return $this->emailService;
    }

    /**
     * @return MailService
     */
    public function getMailService(): MailService
    {
        if (!$this->mailService instanceof MailService) {
            $this->mailService = new MailService();
        }
        return $this->mailService;
    }

    public function emailPerformer(LeaveApplyEvent $event)
    {
        $content = $event->getContent();

        $body = "<p>Hi " . $content['firstName'] . ",</p>
        <p>You have applied for leave. The leave details:</p>
        <table style='text-align:left'>
            <thead>
                <tr>
                    <th style='padding-right:12px;'>Date(s)</th>
                    <th>Duration(Hours)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td style='padding-right:12px;'>" . $content['dateApplied'] . "</td>
                    <td>" . $content['numberOfHours'] . "</td>
                </tr>
            </tbody>
        </table>
        <p>Leave type : " . $content['leaveType'] . "</p>
        <p>Please login to cradleHRM, and either edit or cancel request from Leave List.</p>
        <p>Thank you.</p>
        <p>This is an automated notification.</p>";

        $altBody = "Hi " . $content['firstName'] . ",
        You have applied for leave. The leave details:
        Date(s) " . $content['dateApplied'] . "
        Duration(Hours) " . $content['numberOfHours'] . "
        Leave type : " . $content['leaveType'] . "
        Please login to cradleHRM, and either edit or cancel request from Leave List.
        Thank you.
        This is an automated notification.";

       $this->getMailService()->sendLeaveRequestEmail($content['workEmail'], $content['name'], $content['subject'], $body, $altBody);
    }

    public function emailSupervisor(LeaveApplyEvent $event)
    {
        $supervisors = $event->getSupervisors();
        $content = $event->getContent();
        $this->getMailService()->sendLeaveRequestEmailToSupervisors($supervisors, $content);
    }

    /**
     * @param LeaveAllocate $allocateEvent
     */
    public function onAllocateEvent(LeaveAllocate $allocateEvent): void
    {
        $leaveRequest = $allocateEvent->getDetailedLeaveRequest();
        $leaveRequest->getLeaves();
        if ($allocateEvent instanceof LeaveApply) {
            $emailName = 'leave.apply';
        } elseif ($allocateEvent instanceof LeaveAssign) {
            $emailName = 'leave.assign';
        } else {
            throw new InvalidArgumentException('Invalid instance of `' . LeaveAllocate::class . '` provided');
        }

        $workflow = $allocateEvent->getWorkflow();
        $recipientRoles = $workflow->getDecorator()->getRolesToNotify();
        $performerRole = strtolower($workflow->getRole());

        $this->getEmailService()->queueEmailNotifications($emailName, $recipientRoles, $performerRole, $allocateEvent);
    }

    /**
     * @param LeaveStatusChange $statusChangeEvent
     */
    public function onStatusChangeEvent(LeaveStatusChange $statusChangeEvent): void
    {
        if ($statusChangeEvent instanceof LeaveApprove) {
            $emailName = 'leave.approve';
        } elseif ($statusChangeEvent instanceof LeaveCancel) {
            $emailName = 'leave.cancel';
        } elseif ($statusChangeEvent instanceof LeaveReject) {
            $emailName = 'leave.reject';
        } else {
            throw new InvalidArgumentException('Invalid instance of `' . LeaveAllocate::class . '` provided');
        }

        $workflow = $statusChangeEvent->getWorkflow();
        $recipientRoles = $workflow->getDecorator()->getRolesToNotify();
        $performerRole = strtolower($workflow->getRole());

        $this->getEmailService()->queueEmailNotifications(
            $emailName,
            $recipientRoles,
            $performerRole,
            $statusChangeEvent
        );
    }
}
