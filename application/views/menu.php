<!DOCTYPE html>
<html lang="es">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<link rel="stylesheet" href="<?php echo base_url(); ?>assets/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="<?php echo base_url(); ?>assets/bootstrap/css/style.css">
	<link rel="stylesheet" href="<?php echo base_url(); ?>assets/css/style.css">
	<link rel="stylesheet" href="<?php echo base_url(); ?>assets/css/menu.css">
	<script src="<?php echo base_url(); ?>assets/js/jquery-3.1.1.min.js"></script>
	<script src="<?php echo base_url(); ?>assets/bootstrap/js/bootstrap.min.js"></script>
	<script src="<?php echo base_url(); ?>assets/bootstrap/js/scripts.js"></script>
	<script src='https://www.google.com/recaptcha/api.js'></script>
	<title>Enlistalo</title>
</head>
<body>
	<div class="navbar-wrapper">
	<div class="container-fluid">
		<nav class="navbar navbar-fixed-top">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="base_url"><img id='img-menu' src="<?php echo base_url(); ?>assets/img/enlistalo/logotipo.png"></a>
				</div>
				<div id="navbar" class="navbar-collapse collapse">
					<ul class="nav navbar-nav">
						<li class="down"><a id="crear" data-toggle="modal" data-target="#crearlista">Crear lista</a></li>
						<li class="down"><a href="#">Ver lista</a></li>
						<li class="down"><a href="#">Donar</a></li>
						
					</ul>
					<ul class="nav navbar-nav pull-right">
						<li class=" dropdown"><a href="#" class="dropdown-toggle active" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
						 <?php 
							session_start();
							echo $_SESSION['user'];
						 ?>
						 <span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li><a href="#">Cambiar Contraseña</a></li>
								<li><a href="#">Mi perfil</a></li>
								<li><a href="<?php echo base_url(); ?>controller_usuarios/logout">Cerrar Sesión</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		</nav>
	</div>
</div>

<div id="crearlista" class="modal fade" role="dialog">
  <div class="modal-dialog">
	
	<!-- Modal content-->
	<div class="modal-content">
	  <div class="modal-header" style="background-color:#87CEFA;color:white;border-radius:5px;">
		<button type="button" class="close" data-dismiss="modal">&times;</button>
		<h4 class="modal-title">Crear Lista</h4>
	  </div>
	  <div class="modal-body">
		<form name="crear_lista" autocomplete='off' method='post' action="#">
				<div class="form-group">
					<label for="nom_lista">Nombre de la lista:</label>
					<input type="text" required class="form-control" id='nom_lista' name="nom_lista" maxlength="25">
				</div>
				<div class="form-group">
					<label for="desc_lista">Descripción:</label>
					<textarea display="block" class="form-control" rows="5" id="desc_lista" maxlength="150"></textarea>
				</div>
				<div id="tipo">
				</div>
				<div class="form-group">
					<label for="tipo_lista">Tipo de la lista:</label>
					<select class="form-control" id="tipo_lista" name="tipo_lista">
					   <option>Artículos</option>
					   <option>Pro-Contra</option>
					   
					</select>
				</div>
	
	  </div>
	  <div class="modal-footer">
		<button id="btn-crear" class="btn btn-info" type="submit">Crear lista</button>
		</form>
	  </div>
	</div>

  </div>
</div>
<script>
$("#crear").click( function(){
	var XHR;    
  XHR = new XMLHttpRequest();
  XHR.onreadystatechange = function() {
    if (this.readyState == 4 && this.status == 200) {
      document.getElementById("tipo").innerHTML = this.responseText;
    }
  };
  XHR.open("GET", "listas/vertipo", true);
  XHR.send();
});
</script>
</body>
</html>