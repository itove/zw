<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20240103023214 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SEQUENCE feedback_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE TABLE feedback (id INT NOT NULL, node_id INT DEFAULT NULL, firstname VARCHAR(15) DEFAULT NULL, lastname VARCHAR(15) DEFAULT NULL, email VARCHAR(35) DEFAULT NULL, phone VARCHAR(20) DEFAULT NULL, title VARCHAR(255) DEFAULT NULL, body TEXT NOT NULL, country VARCHAR(30) DEFAULT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE INDEX IDX_D2294458460D9FD7 ON feedback (node_id)');
        $this->addSql('ALTER TABLE feedback ADD CONSTRAINT FK_D2294458460D9FD7 FOREIGN KEY (node_id) REFERENCES node (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('DROP SEQUENCE feedback_id_seq CASCADE');
        $this->addSql('ALTER TABLE feedback DROP CONSTRAINT FK_D2294458460D9FD7');
        $this->addSql('DROP TABLE feedback');
    }
}
