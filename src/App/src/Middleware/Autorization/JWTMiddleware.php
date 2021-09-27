<?php

declare(strict_types=1);

namespace App\Middleware\Autorization;

use Laminas\Diactoros\Response\RedirectResponse;
use Laminas\Diactoros\Response\TextResponse;
use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;
use Firebase\JWT\JWT;

class JWTMiddleware implements MiddlewareInterface
{
    private $config;

    public function __construct(array $config)
    {
        $this->config = $config;
    }

    public function process(ServerRequestInterface $request, RequestHandlerInterface $handler) : ResponseInterface
    {
        $session = $request->getAttribute('session');
        if (! $session->has(UserInterface::class)) {
            return new RedirectResponse('/login');
        }

        return new TextResponse($this->createJWT);
    }

    public function hasValidToken(ServerRequestInterface $request): bool
    {
        JWT::$leeway = $this->config['leeway'];
        $payload = JWT::decode(
            $request->getHeaderLine('Bearer'),
            $this->config['key'],
            $this->config['AllowedAlgorithms']
        );
        $timestamp = (new \DateTime())->getTimestamp();
        return (
            $payload->iss !== $this->config['claim']['iss'] ||
            $payload->aud !== $this->config['claim']['aud'] ||
            $payload->nbf < $timestamp ||
            $payload->exp > $timestamp
        );
    }

    private function createJWT(): string
    {
        $payload = [
            "iss" => $this->config['claim']['iss'],
            "aud" => $this->config['claim']['aud'],
            "iat" => (new \DateTime())->getTimestamp(),
            "nbf" => (new \DateTime())->getTimestamp(),
            "exp" => (new \DateTime())->add(new \DateInterval($this->config['expiryPeriod']))->getTimestamp()
        ];
        return JWT::encode($payload, $this->config['key']);
    }
}
