<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20241022042308 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE user_node DROP CONSTRAINT fk_fffea48c460d9fd7');
        $this->addSql('ALTER TABLE user_node DROP CONSTRAINT fk_fffea48ca76ed395');
        $this->addSql('DROP TABLE user_node');
        $this->addSql('ALTER TABLE node ADD likes INT DEFAULT 0');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('CREATE TABLE user_node (user_id INT NOT NULL, node_id INT NOT NULL, PRIMARY KEY(user_id, node_id))');
        $this->addSql('CREATE INDEX idx_fffea48ca76ed395 ON user_node (user_id)');
        $this->addSql('CREATE INDEX idx_fffea48c460d9fd7 ON user_node (node_id)');
        $this->addSql('ALTER TABLE user_node ADD CONSTRAINT fk_fffea48c460d9fd7 FOREIGN KEY (node_id) REFERENCES node (id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE user_node ADD CONSTRAINT fk_fffea48ca76ed395 FOREIGN KEY (user_id) REFERENCES "user" (id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE node DROP likes');
    }
}
