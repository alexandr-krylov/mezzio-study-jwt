<?php

return [
    'auth' => [
        'jwt' => [
            // A secret key that you've generated in some secure/random fashion.
            'key' => 'XicRF1ZLIUc+NzB4uqdaVlyVNSucfR90kmoAiuOGRi0=',
            'claim' => [
                'iss' => 'https:localdomain.dev',
                'aud' => 'https:localdomain.dev',
            ],
            // A DateTime interval dictating how long the token should be valid for
            'expiryPeriod' => 'P10D',
            'leeway' => 60,
            'allowedAlgorithms' => [
                'HS256'
            ]
        ]
    ],
];