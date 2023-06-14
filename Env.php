<?php

namespace CradleHRM;

use Symfony\Component\Dotenv\Dotenv;

class Env
{
    protected ?Dotenv $dot_env = null;

    /**
     * @return Dotenv
     */
    public function getEnv(): Dotenv
    {
        if (!$this->dot_env instanceof Dotenv) {
            $this->dot_env = new Dotenv();
        }
        return $this->dot_env;
    }

    public function __construct()
    {
        // $rootDir = realpath($_SERVER['DOCUMENT_ROOT']);

        // $env = $rootDir . '.env';

        $env = __DIR__ . '/.env';

        $this->getEnv()->load($env);
    }

    public function loadEnv($env_file)
    {
    	$this->getEnv()->load($env_file);
    }
}
