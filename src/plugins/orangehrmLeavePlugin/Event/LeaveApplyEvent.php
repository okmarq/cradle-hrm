<?php

namespace OrangeHRM\Leave\Event;

use OrangeHRM\Framework\Event\Event;

class LeaveApplyEvent extends Event
{
    public const APPLY = 'leave.email';
    protected array $content;
    protected array $supervisors;

    public function __construct(array $supervisors, array $content)
    {
        $this->content = $content;
        $this->supervisors = $supervisors;
    }

    /**
     * @return array
     */
    public function getContent(): array
    {
        return $this->content;
    }

    /**
     * @return array
     */
    public function getSupervisors(): array
    {
        return $this->supervisors;
    }
}
