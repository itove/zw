<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20241017095256 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SEQUENCE "order_id_seq" INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE SEQUENCE refund_id_seq INCREMENT BY 1 MINVALUE 1 START 1');
        $this->addSql('CREATE TABLE "order" (id INT NOT NULL, node_id INT NOT NULL, consumer_id INT NOT NULL, quantity SMALLINT NOT NULL, amount INT NOT NULL, created_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, paid_at TIMESTAMP(0) WITHOUT TIME ZONE DEFAULT NULL, used_at TIMESTAMP(0) WITHOUT TIME ZONE DEFAULT NULL, status SMALLINT NOT NULL, price INT NOT NULL, cancelled_at TIMESTAMP(0) WITHOUT TIME ZONE DEFAULT NULL, refunded_at TIMESTAMP(0) WITHOUT TIME ZONE DEFAULT NULL, deleted_at TIMESTAMP(0) WITHOUT TIME ZONE DEFAULT NULL, sn VARCHAR(255) NOT NULL, wx_trans_id VARCHAR(255) DEFAULT NULL, bank_type VARCHAR(255) DEFAULT NULL, wx_prepay_id VARCHAR(255) DEFAULT NULL, deleted BOOLEAN NOT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE INDEX IDX_F5299398460D9FD7 ON "order" (node_id)');
        $this->addSql('CREATE INDEX IDX_F529939837FDBD6D ON "order" (consumer_id)');
        $this->addSql('COMMENT ON COLUMN "order".created_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('COMMENT ON COLUMN "order".paid_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('COMMENT ON COLUMN "order".used_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('COMMENT ON COLUMN "order".cancelled_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('COMMENT ON COLUMN "order".refunded_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('COMMENT ON COLUMN "order".deleted_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('CREATE TABLE refund (id INT NOT NULL, ord_id INT NOT NULL, created_at TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, reason SMALLINT NOT NULL, note VARCHAR(255) DEFAULT NULL, sn VARCHAR(255) NOT NULL, wx_refund_id VARCHAR(255) DEFAULT NULL, PRIMARY KEY(id))');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_5B2C1458E636D3F5 ON refund (ord_id)');
        $this->addSql('COMMENT ON COLUMN refund.created_at IS \'(DC2Type:datetime_immutable)\'');
        $this->addSql('ALTER TABLE "order" ADD CONSTRAINT FK_F5299398460D9FD7 FOREIGN KEY (node_id) REFERENCES node (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE "order" ADD CONSTRAINT FK_F529939837FDBD6D FOREIGN KEY (consumer_id) REFERENCES "user" (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE refund ADD CONSTRAINT FK_5B2C1458E636D3F5 FOREIGN KEY (ord_id) REFERENCES "order" (id) NOT DEFERRABLE INITIALLY IMMEDIATE');
        $this->addSql('ALTER TABLE feedback ADD sex SMALLINT DEFAULT NULL');
        $this->addSql('ALTER TABLE feedback ADD province VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE feedback ADD city VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE feedback ADD note VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE feedback ADD name VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE feedback ADD type SMALLINT DEFAULT NULL');
        $this->addSql('ALTER TABLE image ADD title VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE node ADD price INT DEFAULT NULL');
        $this->addSql('ALTER TABLE page ADD weight SMALLINT DEFAULT NULL');
        $this->addSql('ALTER TABLE region ADD weight SMALLINT DEFAULT NULL');
        $this->addSql('ALTER TABLE spec ALTER value DROP NOT NULL');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE SCHEMA public');
        $this->addSql('DROP SEQUENCE "order_id_seq" CASCADE');
        $this->addSql('DROP SEQUENCE refund_id_seq CASCADE');
        $this->addSql('ALTER TABLE "order" DROP CONSTRAINT FK_F5299398460D9FD7');
        $this->addSql('ALTER TABLE "order" DROP CONSTRAINT FK_F529939837FDBD6D');
        $this->addSql('ALTER TABLE refund DROP CONSTRAINT FK_5B2C1458E636D3F5');
        $this->addSql('DROP TABLE "order"');
        $this->addSql('DROP TABLE refund');
        $this->addSql('ALTER TABLE page DROP weight');
        $this->addSql('ALTER TABLE region DROP weight');
        $this->addSql('ALTER TABLE spec ALTER value SET NOT NULL');
        $this->addSql('ALTER TABLE feedback DROP sex');
        $this->addSql('ALTER TABLE feedback DROP province');
        $this->addSql('ALTER TABLE feedback DROP city');
        $this->addSql('ALTER TABLE feedback DROP note');
        $this->addSql('ALTER TABLE feedback DROP name');
        $this->addSql('ALTER TABLE feedback DROP type');
        $this->addSql('ALTER TABLE image DROP title');
        $this->addSql('ALTER TABLE node DROP price');
    }
}
