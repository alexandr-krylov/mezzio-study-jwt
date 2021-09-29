<?php

declare(strict_types=1);

namespace App\Middleware\Authorization;

use Psr\Container\ContainerInterface;

class LoginMiddlewareFactory
{
    public function __invoke(ContainerInterface $container) : LoginMiddleware
    {
        return new LoginMiddleware();
    }
}
