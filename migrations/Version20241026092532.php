<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20241026092532 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SEQUENCE plan_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE TABLE plan (id INT NOT NULL, title VARCHAR(255) NOT NULL, month SMALLINT DEFAULT NULL, days SMALLINT DEFAULT NULL, cost INT DEFAULT NULL, who VARCHAR(255) DEFAULT NULL, body TEXT DEFAULT NULL, summary TEXT DEFAULT NULL, PRIMARY KEY(id))');
        $this->addSql('ALTER TABLE image ADD plan_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE image ADD CONSTRAINT FK_C53D045FE899029B FOREIGN KEY (plan_id) REFERENCES plan (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('CREATE INDEX IDX_C53D045FE899029B ON image (plan_id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('ALTER TABLE image DROP CONSTRAINT FK_C53D045FE899029B');
        $this->addSql('DROP SEQUENCE plan_id_seq CASCADE');
        $this->addSql('DROP TABLE plan');
        $this->addSql('DROP INDEX IDX_C53D045FE899029B');
        $this->addSql('ALTER TABLE image DROP plan_id');
    }
}
