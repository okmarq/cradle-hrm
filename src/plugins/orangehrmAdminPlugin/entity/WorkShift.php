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

namespace OrangeHRM\Entity;

use DateTime;
use Doctrine\ORM\Mapping as ORM;
use OrangeHRM\Entity\Decorator\DecoratorTrait;
use OrangeHRM\entity\Decorator\WorkShiftDecorator;

/**
 * @method WorkShiftDecorator getDecorator()
 *
 * @ORM\Table(name="ohrm_work_shift")
 * @ORM\Entity
 */
class WorkShift
{
    use DecoratorTrait;

    /**
     * @var int
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private int $id;

        /**
     * @var int
     *
     * @ORM\Column(name="organizationId", type="integer", length=4)
     */
    private int $organizationId;


    /**
     * @var string
     *
     * @ORM\Column(name="name", type="string", length=250)
     */
    private string $name;

    /**
     * @var float
     *
     * @ORM\Column(name="hours_per_day", type="decimal", precision=4, scale=2)
     */
    private float $hoursPerDay;

    /**
     * @var DateTime
     *
     * @ORM\Column(name="start_time", type="time")
     */
    private DateTime $startTime;

    /**
     * @var DateTime
     *
     * @ORM\Column(name="end_time", type="time")
     */
    private DateTime $endTime;

    /**
     * @return int
     */
    public function getId(): int
    {
        return $this->id;
    }

    /**
     * @param int $id
     */
    public function setId(int $id): void
    {
        $this->id = $id;
    }


    /**
     * @return int
     */
    public function getOrganizationId(): int
    {
        return $this->organizationId;
    }

    /**
     * @param int $organizationId
     */
    public function setOrganizationId(int $organizationId): void
    {
        $this->organizationId = $organizationId;
    }

    /**
     * @return string
     */
    public function getName(): string
    {
        return $this->name;
    }

    /**
     * @param string $name
     */
    public function setName(string $name): void
    {
        $this->name = $name;
    }

    /**
     * @return float
     */
    public function getHoursPerDay(): float
    {
        return $this->hoursPerDay;
    }

    /**
     * @param float $hoursPerDay
     */
    public function setHoursPerDay(float $hoursPerDay): void
    {
        $this->hoursPerDay = $hoursPerDay;
    }

    /**
     * @return DateTime
     */
    public function getStartTime(): DateTime
    {
        return $this->startTime;
    }

    /**
     * @param DateTime $startTime
     */
    public function setStartTime(DateTime $startTime): void
    {
        $this->startTime = $startTime;
    }

    /**
     * @return DateTime
     */
    public function getEndTime(): DateTime
    {
        return $this->endTime;
    }

    /**
     * @param DateTime $endTime
     */
    public function setEndTime(DateTime $endTime): void
    {
        $this->endTime = $endTime;
    }
}
