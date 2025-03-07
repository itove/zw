<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20241022084812 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SEQUENCE down_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE TABLE down (id INT NOT NULL, node_id INT NOT NULL, u_id INT NOT NULL, created_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE INDEX IDX_1CFF903B460D9FD7 ON down (node_id)');
        $this->addSql('CREATE INDEX IDX_1CFF903BE4A59390 ON down (u_id)');
        $this->addSql('COMMENT ON COLUMN down.created_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('ALTER TABLE down ADD CONSTRAINT FK_1CFF903B460D9FD7 FOREIGN KEY (node_id) REFERENCES node (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE down ADD CONSTRAINT FK_1CFF903BE4A59390 FOREIGN KEY (u_id) REFERENCES "user" (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('DROP SEQUENCE down_id_seq CASCADE');
        $this->addSql('ALTER TABLE down DROP CONSTRAINT FK_1CFF903B460D9FD7');
        $this->addSql('ALTER TABLE down DROP CONSTRAINT FK_1CFF903BE4A59390');
        $this->addSql('DROP TABLE down');
    }
}
