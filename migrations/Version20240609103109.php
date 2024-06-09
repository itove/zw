<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20240609103109 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE user_node (user_id INT NOT NULL, node_id INT NOT NULL, PRIMARY KEY(user_id, node_id))');
        $this->addSql('CREATE INDEX IDX_FFFEA48CA76ED395 ON user_node (user_id)');
        $this->addSql('CREATE INDEX IDX_FFFEA48C460D9FD7 ON user_node (node_id)');
        $this->addSql('ALTER TABLE user_node ADD CONSTRAINT FK_FFFEA48CA76ED395 FOREIGN KEY (user_id) REFERENCES "user" (id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE user_node ADD CONSTRAINT FK_FFFEA48C460D9FD7 FOREIGN KEY (node_id) REFERENCES node (id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE user_node DROP CONSTRAINT FK_FFFEA48CA76ED395');
        $this->addSql('ALTER TABLE user_node DROP CONSTRAINT FK_FFFEA48C460D9FD7');
        $this->addSql('DROP TABLE user_node');
    }
}
