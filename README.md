# PHP.PSR-1.lab

Laboratory of PSR-1: Basic Coding Standard.

> This repository is a standalone part of a larger project: **[PHP.lab](https://github.com/katheroine/php.lab)** — a curated knowledge base and laboratory for PHP engineering.

**Usage**

To run the example application with *Docker* use command:

```console
docker compose up -d
```

After creating the *Docker container* the *Composer dependencies* have to be defined and installed:

```console
docker compose exec application composer require --dev squizlabs/php_codesniffer \
&& docker compose exec -w /var/www application composer install
```

Tom make *PHP Code Sniffer commands* easily accessible run:

```console
docker compose exec application ln -s /var/www/vendor/bin/phpcs /usr/local/bin/phpcs \
&& docker compose exec application ln -s /var/www/vendor/bin/phpcbf /usr/local/bin/phpcbf
```

To run *PHP Code Sniffer* use command:

```console
docker compose exec application /var/www/vendor/bin/phpcs
```

or, if the shortcut has been created:

```console
docker compose exec application phpcs
```

To update `Composer dependencies` use command (should be done before the command below):

```console
docker compose exec application composer update
```

To login into the *Docker container* use command:

```console
docker exec -it psr-1-example-app /bin/bash
```

**License**

This project is licensed under the GPL-3.0 - see [LICENSE.md](LICENSE.md).

**What are PSRs**

[PHP-FIG PRS-1 Official documentation](https://www.php-fig.org/psr/psr-1/)

**PSR** stands for *PHP Standard Recommendation*.

## Files

##### ✤ Character encoding

**Files MUST use only `UTF-8` without `BOM` for PHP code.**
[🔗](https://www.php-fig.org/psr/psr-1/#1-overview)

[UTF-8](https://en.wikipedia.org/wiki/UTF-8) is a variable-length character encoding standard used for electronic communication.
Defined by the [Unicode Standard](https://en.wikipedia.org/wiki/Unicode), the name is derived from *Unicode Transformation Format - 8-bit*.

The [byte-order mark (BOM)](https://en.wikipedia.org/wiki/Byte_order_mark) is a particular usage of the special Unicode character code, U+FEFF ZERO WIDTH NO-BREAK SPACE, whose appearance as a magic number at the start of a text stream can signal several things to a program reading the text:
* the byte order, or endianness, of the text stream in the cases of 16-bit and 32-bit encodings;
* the fact that the text stream's encoding is Unicode, to a high level of confidence;
* which Unicode character encoding is used.

BOM use in UTF-8 is optional. Its presence interferes with the use of UTF-8 by software that does not expect non-ASCII bytes at the start of a file but that could otherwise handle the text stream.

##### ✤ PHP tag types

**Files MUST use only `<?php` and `<?=` tags.**
[🔗](https://www.php-fig.org/psr/psr-1/#21-php-tags)

*Example of code using `<?php` and `<?=` tags only*

**`view.php`**

```php
<!doctype html>
<html lang="<?= $html_doc_language_code ?>">
  <head>
    <meta charset="<?= $html_doc_charset ?>">
    <meta name="language" content="<?= $html_doc_language ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="<?= $html_doc_description ?>">
    <meta name="keywords" content="<?= $html_doc_keywords ?>">
    <meta name="author" content="<?= $html_doc_author['name'] ?> <<?= $html_doc_author['email'] ?>>">
    <title><?= $html_doc_title ?></title>
  </head>
  <body>
    <?php if (isset($header)): ?>
    <header>
        <?= $header ?>
    </header>
    <?php endif; ?>
    <?php if (isset($content)): ?>
    <div id="content">
        <?= $content ?>
    </div>
    <?php endif; ?>
    <?php if (isset($footer)): ?>
    <footer>
        <?= $footer ?>
    </footer>
    <?php endif; ?>
  </body>
</html>

```

**`index.php`**

```php
<?php

$html_doc_language_code = 'en-GB';
$html_doc_charset = 'utf-8';
$html_doc_language = 'english';
$html_doc_description = 'PSR-1 example document';
$html_doc_keywords = 'php,psr,psr-1';
$html_doc_author = [
    'name' => 'Some Author',
    'email' => 'author@php.lab',
];
$html_doc_title = 'Some PSR-1 example page';

$header = 'PSR-1 example';
$content = 'Hi, there!';
$footer = 'Copyright PHP.PSR-1.lab 2026';

require_once('view.php');

```

##### ✤ Files purpose

**A file SHOULD `declare new symbols` (classes, functions, constants, etc.) and cause no other `side effects`, or it SHOULD `execute logic` with side effects, but SHOULD NOT do both.**
[🔗](https://www.php-fig.org/psr/psr-1/#23-side-effects)

The phrase *side effects* means execution of logic not directly related to declaring classes, functions, constants, etc., merely from including the file.

*Side effects* include but are not limited to: generating output, explicit use of require or include, connecting to external services, modifying `ini` settings, emitting errors or exceptions, modifying global or static variables, reading from or writing to a file, and so on.

-- [PHP Reference](https://www.php-fig.org/psr/psr-1/#23-side-effects)

*WARNING! By `logic` we understand any logic of the code here, not strictly the business (domain) logic.*

*Example of file **declaring of new symbol***

**`HtmlDoc.php`**

```php
<?php

class HtmlDoc
{
    public $languageCode = 'en-GB';
    public $charset = 'utf-8';
    public $language = 'english';
    public $description = 'PSR-1 example document';
    public $keywords = 'php,psr,psr-1';
    public $author = [
        'name' => 'Some Author',
        'email' => 'author@php.lab',
    ];
    public $title = 'Some PSR-1 example page';
    public $header = 'PSR-1 example';
    public $footer = 'Copyright PHP.lab 2024';
    public $content = 'Hi, there!';
}

```

*Example of files **executing the logic** (with *side effects*)*

**`view.php`**

```php
<!doctype html>
<html lang="<?= $htmlDoc->languageCode ?>">
  <head>
    <meta charset="<?= $htmlDoc->charset ?>">
    <meta name="language" content="<?= $htmlDoc->language ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="<?= $htmlDoc->description ?>">
    <meta name="keywords" content="<?= $htmlDoc->keywords ?>">
    <meta name="author" content="<?= $htmlDoc->author['name'] ?> <<?= $htmlDoc->author['email'] ?>>">
    <title><?= $htmlDoc->title ?></title>
  </head>
  <body>
    <?php if (isset($htmlDoc->header)): ?>
    <header>
        <?= $htmlDoc->header ?>
    </header>
    <?php endif; ?>
    <?php if (isset($htmlDoc->content)): ?>
    <div id="content">
        <?= $htmlDoc->content ?>
    </div>
    <?php endif; ?>
    <?php if (isset($htmlDoc->footer)): ?>
    <footer>
        <?= $htmlDoc->footer ?>
    </footer>
    <?php endif; ?>
  </body>
</html>

```

**`index.php`**

```php
<?php

include(__DIR__ . DIRECTORY_SEPARATOR . 'HtmlDoc.php');

$htmlDoc = new HtmlDoc();

require_once('view.php');

```
