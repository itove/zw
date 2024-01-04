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
    foreach ($props as $prop) {
        array_push($arr, $prop->getName());
    }
    return $arr;
}
