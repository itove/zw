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
use App\Entity\Page;
use App\Entity\Language;

class Data
{
    private $doctrine;
    
    public function __construct(ManagerRegistry $doctrine)
    {
        $this->doctrine = $doctrine;
    }
    
    static function GetProperties($entity)
    {
        $reflect = new \ReflectionClass($entity);
        // $props   = $reflect->getProperties(\ReflectionProperty::IS_PRIVATE);
        $props   = $reflect->getProperties();
        $arr = [];
        $no_need = ['title', 'regions', 'imageFile', 'language'];
        foreach ($props as $prop) {
            $prop_name = $prop->getName();
            if (!in_array($prop_name, $no_need)) {
                // array_push($arr, $prop->getName());
                $arr[$prop_name] = $prop_name;
            }
        }
        return $arr;
    }
    
    public function getPage(string $label)
    {
        $page = $this->doctrine->getRepository(Page::class)->findOneBy(['label' => $label]);
        return $page;
    }
    
    public function getRegionByLabel(string $label)
    {
        $region = $this->doctrine->getRepository(Region::class)->findOneBy(['label' => $label]);
        return $region;
    }
    
    public function getNode(int $id)
    {
        $node = $this->doctrine->getRepository(Node::class)->find($id);
        return $node;
    }
    
    public function getPageContent(string $label, $locale)
    {
        $page = $this->doctrine->getRepository(Page::class)->findOneBy(['label' => $label]);
        $regions = $page->getRegions();
        $data = [];
        foreach ($regions as $r) {
            $dataOfRegion = self::findNodesByRegion($r, $locale);
            $data[$r->getLabel()] = $dataOfRegion;
        }
        
        $data['footer'] = self::findNodesByRegion(self::getFooterRegion(), $locale);
        $data['conf'] = self::findConfByLocale($locale);
        
        return $data;
    }
    
    public function getFooterRegion()
    {
        $region = $this->doctrine->getRepository(Region::class)->findOneBy(['label' => 'footer']);
        return $region;
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
                // $arr[$r->getLabel()] = $nodeRepo->findOneBy(['region' => $r]);
            }
        }
        
        return $arr;
    }
    
    public function getNodeByRegion(string $region, $limit = null, $offset = null)
    {
        $nodes = $this->doctrine->getRepository(Node::class)->findByRegion(['region' => $region], $limit, $offset);
        return $nodes;
    }
    
    public function findNodeByRegion(string $region, $limit = null, $offset = null)
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
   
    public function get($nid, $entity = Node::class)
    {
      return $this->doctrine->getRepository($entity)->find($nid);
    }
    
    public function find($nid, $entity = Node::class)
    {
      return $this->doctrine->getRepository($entity)->find($nid);
    }
    
    public function findNodeByTag(string $tag, $limit = null, $offset = null)
    {
        $nodes = $this->doctrine->getRepository(Node::class)->findByTag($tag, $limit, $offset);
        return $nodes;
    }
    
    public function findNodeByCategory(string $category, $limit = null, $offset = null)
    {
        $nodes = $this->doctrine->getRepository(Node::class)->findByCategory($category, $limit, $offset);
        return $nodes;
    }
    
    public function findNodeByRegionAndLocale($region_label, $locale)
    {
      $language = $this->findOneBy(['locale' => $locale], Language::class);
      $region = $this->findOneBy(['label' => $region_label], Region::class);
      $node = $this->findOneBy(['language' => $language, 'region' => $region]);
        
      return $node;
    }
    
    public function findNodesByRegionAndLocale($region_label, $locale)
    {
      $language = $this->findOneBy(['locale' => $locale], Language::class);
      $region = $this->findOneBy(['label' => $region_label], Region::class);
      $nodes = $this->findBy(['language' => $language, 'region' => $region]);
        
      return $nodes;
    }
    
    public function findNodesByRegion(Region $region, $locale, $limit = null, $offset = null)
    {
      return $this->doctrine->getRepository(Node::class)->findByRegion($region, $locale, $limit, $offset);
    }
    
    public function findNodesByRegionLabel(string $label, $locale, $limit = null, $offset = null)
    {
      $region = $this->doctrine->getRepository(Region::class)->findOneBy(['label' => $label]);
      return $this->doctrine->getRepository(Node::class)->findByRegion($region, $locale, $limit, $offset);
    }
    
    public function findConfByLocale($locale)
    {
      $language = $this->findOneBy(['locale' => $locale], Language::class);
      $conf = $this->findOneBy(['language' => $language], Conf::class);
        
      return $conf;
    }
    
    public function findBy($criteria, $entity = Node::class)
    {
      return $this->doctrine->getRepository($entity)->findBy($criteria);
    }
    
    public function findOneBy($criteria, $entity = Node::class)
    {
      return $this->doctrine->getRepository($entity)->findOneBy($criteria);
    }
    
    public function findAll($criteria, $entity = Node::class)
    {
      return $this->doctrine->getRepository($entity)->findAll($criteria);
    }
    
    /*
     * Get all site basic infomation in one place, add logic as you need
     */
    public function getInfo(string $locale)
    {
      $conf = $this->findConfByLocale($locale);
      $categories = $this->findAll([], Category::class);
      // $more = $this->findAll([], More::class);
      
      return [
        'conf' => $conf,
        'categories' => $categories,
        // 'more' => $more,
      ];
    }
    
    public function findNodeByCategoryAndRegion($cate_label, $region_label, int $limit)
    {
      return $this->doctrine->getRepository(Node::class)
                            ->findByCategoryAndRegion(['category' => $cate_label, 'region' => $region_label], [], $limit)
                        ;
    }
    
    public function findNodeByCategoryAndTag($cate_label, $tag_label, int $limit)
    {
      return $this->doctrine->getRepository(Node::class)
                            ->findByCategoryAndTag(['category' => $cate_label, 'tag' => $tag_label], [], $limit)
                        ;
    }
}
