<?php
/*
 * Copyright (C) 2026 Katarzyna Krasińska
 * PHP.PSR-1.lab - https://github.com/katheroine/php.psr-1.lab
 * Licensed under GPL-3.0 - see LICENSE.md
 */

require_once(__DIR__ . '/../vendor/autoload.php');

use PHPLab\StandardPSR1\HtmlDoc;
use PHPLab\StandardPSR1\HtmlDocAuthor;

$htmlDoc = new HtmlDoc();
$htmlDocAuthor = new HtmlDocAuthor();
$htmlDoc->setAuthor($htmlDocAuthor);

require_once('view.php');
