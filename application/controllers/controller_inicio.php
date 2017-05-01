<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Controller_inicio extends CI_Controller {

	public function index() {
		$this->load->view('inicio');
		$this->load->view('footer');
	}
	
	public function error() {
		$this->load->view('cabecera');
		$this->load->view('error');
		$this->load->view('footer');

	}
	
}