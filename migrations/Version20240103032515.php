<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20240103032515 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE conf ADD language_id INT NOT NULL');
        $this->addSql('ALTER TABLE conf ADD CONSTRAINT FK_14F389A882F1BAF4 FOREIGN KEY (language_id) REFERENCES language (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('CREATE INDEX IDX_14F389A882F1BAF4 ON conf (language_id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE conf DROP CONSTRAINT FK_14F389A882F1BAF4');
        $this->addSql('DROP INDEX IDX_14F389A882F1BAF4');
        $this->addSql('ALTER TABLE conf DROP language_id');
    }
}
