<?php

namespace App\Form\DataTransformer;

use Symfony\Component\Form\DataTransformerInterface;
use Symfony\Component\HttpFoundation\File\File;

class StringToFileTransformer implements DataTransformerInterface
{
private string $imageDirectory;

public function __construct(string $imageDirectory)
{
$this->imageDirectory = $imageDirectory;
}

public function transform($value)
{
if (null === $value) {
return '';
}

if (!$value instanceof File) {
throw new \LogicException('Le transformateur s\'attend à une instance de File.');
}

return $value->getRealPath();
}

public function reverseTransform($value)
{
if (!$value) {
return null;
}

    return $value;
}
}
