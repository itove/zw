<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20241022085348 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE down ADD comment_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE down ADD CONSTRAINT FK_1CFF903BF8697D13 FOREIGN KEY (comment_id) REFERENCES comment (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('CREATE INDEX IDX_1CFF903BF8697D13 ON down (comment_id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE down DROP CONSTRAINT FK_1CFF903BF8697D13');
        $this->addSql('DROP INDEX IDX_1CFF903BF8697D13');
        $this->addSql('ALTER TABLE down DROP comment_id');
    }
}
