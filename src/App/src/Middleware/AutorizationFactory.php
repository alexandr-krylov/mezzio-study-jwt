<?php

declare(strict_types=1);

namespace App\Middleware;

use Psr\Container\ContainerInterface;

class AutorizationFactory
{
    public function __invoke(ContainerInterface $container) : Autorization
    {
        return new Autorization();
    }
}
