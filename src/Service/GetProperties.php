<?php
/**
 * vim:ft=php et ts=4 sts=4
 * @author Al Zee <z@alz.ee>
 * @version
 * @todo
 */

namespace App\Service;

function GetProperties($entity)
{
    $reflect = new \ReflectionClass($entity);
    // $props   = $reflect->getProperties(\ReflectionProperty::IS_PRIVATE);
    $props   = $reflect->getProperties();
    $arr = [];
    $no_need = ['region', 'imageFile', 'language'];
    foreach ($props as $prop) {
        $prop_name = $prop->getName();
        if (!in_array($prop_name, $no_need)) {
            // array_push($arr, $prop->getName());
            $arr[$prop_name] = $prop_name;
        }
    }
    return $arr;
}
