<?php
/**
 * Created by PhpStorm.
 * User: ltochapn
 * Date: 18/04/2019
 * Time: 10:54
 */

namespace App\Controller;


use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;

class DefaultController extends AbstractController
{

	/**
	 * @Route("/", name="home")
	 */
	public function home() {
		return $this->render('login/login.html.twig');
	}
}