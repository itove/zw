<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20241026093431 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SEQUENCE step_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE TABLE step (id INT NOT NULL, plan_id INT NOT NULL, datetime TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, body TEXT DEFAULT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE INDEX IDX_43B9FE3CE899029B ON step (plan_id)');
        $this->addSql('COMMENT ON COLUMN step.datetime IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('ALTER TABLE step ADD CONSTRAINT FK_43B9FE3CE899029B FOREIGN KEY (plan_id) REFERENCES plan (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('DROP SEQUENCE step_id_seq CASCADE');
        $this->addSql('ALTER TABLE step DROP CONSTRAINT FK_43B9FE3CE899029B');
        $this->addSql('DROP TABLE step');
    }
}
