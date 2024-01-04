<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20240104063917 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE spec ADD node_id INT NOT NULL');
        $this->addSql('ALTER TABLE spec ADD CONSTRAINT FK_C00E173E460D9FD7 FOREIGN KEY (node_id) REFERENCES node (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('CREATE INDEX IDX_C00E173E460D9FD7 ON spec (node_id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE spec DROP CONSTRAINT FK_C00E173E460D9FD7');
        $this->addSql('DROP INDEX IDX_C00E173E460D9FD7');
        $this->addSql('ALTER TABLE spec DROP node_id');
    }
}
