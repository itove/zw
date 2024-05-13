<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20240513143315 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE region_region DROP CONSTRAINT fk_1cb60d234c5e8326');
        $this->addSql('ALTER TABLE region_region DROP CONSTRAINT fk_1cb60d2355bbd3a9');
        $this->addSql('DROP TABLE region_region');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('CREATE TABLE region_region (region_source INT NOT NULL, region_target INT NOT NULL, PRIMARY KEY(region_source, region_target))');
        $this->addSql('CREATE INDEX idx_1cb60d2355bbd3a9 ON region_region (region_target)');
        $this->addSql('CREATE INDEX idx_1cb60d234c5e8326 ON region_region (region_source)');
        $this->addSql('ALTER TABLE region_region ADD CONSTRAINT fk_1cb60d234c5e8326 FOREIGN KEY (region_source) REFERENCES region (id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE region_region ADD CONSTRAINT fk_1cb60d2355bbd3a9 FOREIGN KEY (region_target) REFERENCES region (id) ON DELETE CASCADE NOT DEFERRABLE INITIALLY IMMEDIATE');
    }
}
