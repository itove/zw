#!/bin/bash
#
# vim:ft=sh

############### Variables ###############

############### Functions ###############

############### Main Part ###############


for i in {1..50}
do
    # cp NodeCrudController.php _N$i.php
    # sed -i "/class NodeCrudController/s/NodeCrudController/_N$i/" _N$i.php

    echo "<?php

namespace App\Controller\Admin;

class _N$i extends NodeCrudController
{
}" > _N$i.php

done
