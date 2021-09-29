<?php

return [
    'authentication' => [
        'redirect' => '/login',
        'pdo' => [
            'dsn' => 'pgsql:host=db;port=5432;dbname=db_test;user=db_test;password=db_test',
            'username' => 'db_test',
            'password' => 'db_test',
            'table' => 'user table name',
            'field' => [
                'identity' => 'identity field name',
                'password' => 'password field name',
            ],
            'sql_get_roles'   => 'SQL to retrieve roles with :identity parameter',
            'sql_get_details' => 'SQL to retrieve user details by :identity',
        ],
    ],
];
