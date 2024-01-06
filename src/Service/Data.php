<?php
/**
 * vim:ft=php et ts=4 sts=4
 * @author Al Zee <z@alz.ee>
 * @version
 * @todo
 */

namespace App\Service;

use Doctrine\Persistence\ManagerRegistry;
use App\Entity\Conf;
use App\Entity\Node;
use App\Entity\Tag;
use App\Entity\Region;

class Data
{
    private $doctrine;
    
    public function __construct(ManagerRegistry $doctrine)
    {
        $this->doctrine = $doctrine;
    }
    
    public function getSome($nid = null)
    {
        $conf = $this->doctrine->getRepository(Conf::class)->find(1);
        $nodeRepo = $this->doctrine->getRepository(Node::class);
        $regions = $this->doctrine->getRepository(Region::class)->findAll();
        $arr = [
            'description' => $conf->getDescription(),
            'keywords' => $conf->getKeywords(),
            'site_name' => $conf->getSitename(),
            'address' => $conf->getAddress(),
            'phone' => $conf->getPhone(),
            'email' => $conf->getEmail(),
        ];
        
        if (!is_null($nid)) {
            $arr['node'] = $this->doctrine->getRepository(Node::class)->find($nid);
        }
        
        foreach($regions as $r ) {
            $limit = $r->getCount();
            if ($limit > 0) {
                $order = 'DESC';
            } else {
                $order = 'ASC';
            }
            if ($limit !== 0) {
                $arr[$r->getLabel()] = $nodeRepo->findBy(['region' => $r], ['id' => $order], abs($limit));
            } else {
                $arr[$r->getLabel()] = $nodeRepo->findOneBy(['region' => $r]);
            }
        }
        
        return $arr;
    }
    
    public function getNodeByRegion(string $region, $limit = null, $offset = null)
    {
        $nodes = $this->doctrine->getRepository(Node::class)->findByRegion(['region' => $region], $limit, $offset);
        return $nodes;
    }
    
    public function getNodeByTag(string $tag, $limit = null, $offset = null)
    {
        $nodes = $this->doctrine->getRepository(Node::class)->findByTag(['tag' => $tag], $limit, $offset);
        return $nodes;
    }
    
    public function getTagByLabel(string $label)
    {
        $tag = $this->doctrine->getRepository(Tag::class)->findOneBy(['label' => $label]);
        return $tag;
    }
   
    public function get($nid)
    {
      return $this->doctrine->getRepository(Node::class)->find($nid);
    }
}

