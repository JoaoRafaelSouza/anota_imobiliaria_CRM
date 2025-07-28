<?php
namespace App\Config;

use PDO;
use PDOException;

class Conexao
{
    public static function Conectar()
    {
        $envPath = __DIR__ . '/../.env.local';
        if (!file_exists($envPath)) {
            die("Arquivo .env.local não encontrado.");
        }

        $env = parse_ini_file($envPath);
        $host = $env['DB_HOST'] ?? 'localhost';
        $dbname = $env['DB_DATABASE'];
        $user = $env['DB_USERNAME'];
        $pass = $env['DB_PASSWORD'];

        try {
            $pdo = new PDO("mysql:host=$host;dbname=$dbname;charset=utf8", $user, $pass);
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            return $pdo;
        } catch (PDOException $e) {
            error_log($e->getMessage());
            die("Erro ao conectar ao banco de dados.");
        }
    }
}