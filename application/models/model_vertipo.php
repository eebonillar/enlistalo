 <?php
if ( ! defined('BASEPATH')) exit('No direct script access allowed');
	class Model_vertipo extends CI_Model{

 public function verTipo(){
   		 	$con = $this->db->get('tipo_lista');
   		 	$resultado = $con->result_array();
   		 	?>
   		 		<div class="form-group">
					<label for="tipo_lista">Tipo de la lista:</label>
					<select class="form-control" id="tipo_lista" name="tipo_lista">
				        <?php
				        	foreach ($resultado as $item) {
				        		echo "<option value='".$item['id_tipo']."' >".$item['nombre_tipo']."</option>";
				        	}
				        ?>
				     </select>
				</div>
	}