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

namespace OrangeHRM\Installer\Util;

use Doctrine\DBAL\Connection as DBALConnection;
use Doctrine\DBAL\DriverManager;
use Doctrine\DBAL\Types\Types;
use OrangeHRM\Core\Traits\ServiceContainerTrait;
use OrangeHRM\Framework\Logger\Logger;
use OrangeHRM\Framework\Services;
use Throwable;
use Symfony\Component\Dotenv\Dotenv;

class Connection
{
    use ServiceContainerTrait;

    /**
     * @var DBALConnection|null
     */
    private static ?DBALConnection $connection = null;

    private function __construct()
    {
        (new Dotenv())->load('../.env');
        $dbInfo = StateContainer::getInstance()->getDbInfo();
       
        if(!is_null($dbInfo[StateContainer::DB_NAME])){
            $connectionParams = [
                'dbname' => $dbInfo[StateContainer::DB_NAME],
                'user' => $dbInfo[StateContainer::DB_USER],
                'password' => $dbInfo[StateContainer::DB_PASSWORD],
                'host' => $dbInfo[StateContainer::DB_HOST],
                'port' => $dbInfo[StateContainer::DB_PORT],
                'driver' => 'pdo_mysql',
                'charset' => 'utf8mb4'
            ];
        }else{
            $connectionParams = [
                'dbname'=> $_ENV['DB_NAME'],
                'user'=> $_ENV['DB_USER'],
                'password'=> $_ENV['DB_PASS'],
                'host'=>$_ENV['DB_HOST'],
                'port'=>$_ENV['DB_PORT'],
                'driver'=>'pdo_mysql',
                'charset'=>'utf8mb4'
            ];
        }

        //dd($connectionParams);
       
        self::$connection = DriverManager::getConnection($connectionParams);
       
        self::$connection->getDatabasePlatform()->registerDoctrineTypeMapping('enum', Types::STRING);

        try {
            /** @var Logger $logger */
            $logger = $this->getContainer()->get(Services::LOGGER);
            $systemConfig = new SystemConfig();
            $logger->info('Instance details: ' . json_encode($systemConfig->getSystemDetails()));
        } catch (Throwable $e) {
        }
    }

    /**
     * @return DBALConnection
     */
    public static function getConnection(): DBALConnection
    {
        if (is_null(self::$connection)) {
           
            new self();
        }
        //dd(self::$connection);
        return self::$connection;
    }
}
