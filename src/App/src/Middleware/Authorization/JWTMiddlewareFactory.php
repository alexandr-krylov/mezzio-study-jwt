<?php

declare(strict_types=1);

namespace App\Middleware\Authorization;

use Psr\Container\ContainerInterface;

class JWTMiddlewareFactory
{
    public function __invoke(ContainerInterface $container) : JWTMiddleware
    {
        $config = $container->has('config') ? $container->get('config') : [];
//        var_dump($config);
//        exit();
        return new JWTMiddleware($config['auth']['jwt']);
    }
}
