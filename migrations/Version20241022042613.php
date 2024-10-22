<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20241022042613 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE comment DROP CONSTRAINT fk_9474526cb4d5a9e2');
        $this->addSql('DROP INDEX idx_9474526cb4d5a9e2');
        $this->addSql('ALTER TABLE comment RENAME COLUMN commenter_id TO author_id');
        $this->addSql('ALTER TABLE comment ADD CONSTRAINT FK_9474526CF675F31B FOREIGN KEY (author_id) REFERENCES "user" (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('CREATE INDEX IDX_9474526CF675F31B ON comment (author_id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE comment DROP CONSTRAINT FK_9474526CF675F31B');
        $this->addSql('DROP INDEX IDX_9474526CF675F31B');
        $this->addSql('ALTER TABLE comment RENAME COLUMN author_id TO commenter_id');
        $this->addSql('ALTER TABLE comment ADD CONSTRAINT fk_9474526cb4d5a9e2 FOREIGN KEY (commenter_id) REFERENCES "user" (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('CREATE INDEX idx_9474526cb4d5a9e2 ON comment (commenter_id)');
    }
}
