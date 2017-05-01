<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Listas extends CI_Controller {

	public function index() {
		$this->load->view('menu');
		//$this->load->view('verlista');
		$this->load->view('footer');
	}
	
	public function crear() {
		$this->load->view('menu');
		$this->load->view('crearlista');
		$this->load->view('footer');

	}
}