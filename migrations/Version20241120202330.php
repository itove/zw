<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20241120202330 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE plan DROP CONSTRAINT fk_dd5a5b7d460d9fd7');
        $this->addSql('DROP INDEX idx_dd5a5b7d460d9fd7');
        $this->addSql('ALTER TABLE plan DROP node_id');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE plan ADD node_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE plan ADD CONSTRAINT fk_dd5a5b7d460d9fd7 FOREIGN KEY (node_id) REFERENCES node (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('CREATE INDEX idx_dd5a5b7d460d9fd7 ON plan (node_id)');
    }
}
