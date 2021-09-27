<?php

declare(strict_types=1);

namespace App\Handler;

use Mezzio\Template\TemplateRendererInterface;
use Psr\Container\ContainerInterface;

class JWTHandlerFactory
{
    public function __invoke(ContainerInterface $container) : JWTHandler
    {
        return new JWTHandler($container->get(TemplateRendererInterface::class));
    }
}
