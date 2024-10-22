<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20241022085250 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE up ADD comment_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE up ADD CONSTRAINT FK_4394EE70F8697D13 FOREIGN KEY (comment_id) REFERENCES comment (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('CREATE INDEX IDX_4394EE70F8697D13 ON up (comment_id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE up DROP CONSTRAINT FK_4394EE70F8697D13');
        $this->addSql('DROP INDEX IDX_4394EE70F8697D13');
        $this->addSql('ALTER TABLE up DROP comment_id');
    }
}
