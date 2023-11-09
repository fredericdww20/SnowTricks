<?php

namespace App\Form;

use App\Entity\Image;
use App\Form\DataTransformer\StringToFileTransformer;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\HiddenType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Form\Extension\Core\Type\FileType;

class ImageFormType extends AbstractType
{
    private string $imageDirectory;

    public function __construct(string $imageDirectory)
    {

        $this->imageDirectory = $imageDirectory;

    }

    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('filename', FileType::class, [
                'mapped' => false,
                'required' => false,
                
            ]);

        $transformer = new StringToFileTransformer($this->imageDirectory);
        $builder
            ->get('filename')->addModelTransformer($transformer);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Image::class,

        ]);
    }
}
