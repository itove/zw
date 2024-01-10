<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20240110143750 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE node_region (node_id INT NOT NULL, region_id INT NOT NULL, PRIMARY KEY(node_id, region_id))');
        $this->addSql('CREATE INDEX IDX_BB70E4D3460D9FD7 ON node_region (node_id)');
        $this->addSql('CREATE INDEX IDX_BB70E4D398260155 ON node_region (region_id)');
        $this->addSql('ALTER TABLE node_region ADD CONSTRAINT FK_BB70E4D3460D9FD7 FOREIGN KEY (node_id) REFERENCES node (id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE node_region ADD CONSTRAINT FK_BB70E4D398260155 FOREIGN KEY (region_id) REFERENCES region (id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE node DROP CONSTRAINT fk_857fe84598260155');
        $this->addSql('DROP INDEX idx_857fe84598260155');
        $this->addSql('ALTER TABLE node DROP region_id');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE node_region DROP CONSTRAINT FK_BB70E4D3460D9FD7');
        $this->addSql('ALTER TABLE node_region DROP CONSTRAINT FK_BB70E4D398260155');
        $this->addSql('DROP TABLE node_region');
        $this->addSql('ALTER TABLE node ADD region_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE node ADD CONSTRAINT fk_857fe84598260155 FOREIGN KEY (region_id) REFERENCES region (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('CREATE INDEX idx_857fe84598260155 ON node (region_id)');
    }
}
