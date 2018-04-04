
<!DOCTYPE html>
 <html lang="fr">
 <head>
     <meta charset="UTF-8">
     <title>Map</title>
     <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
     <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.3/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zug+QiDoJOrZ5t4lssLdxGhVrurbmBWopoEl+M6BdEfwnCJZtKxi1KgxUyJq13dy" crossorigin="anonymous">
     <link href="https://fonts.googleapis.com/css?family=Raleway" rel="stylesheet"> 
     <link rel="stylesheet" type="text/css" href="css/style.css">
 </head>

<body>
        <div class="menu text-center py-3">
            <h1>Établissements du second degré en France en 2017</h1>
        </div>

        <!-- Formulaire pour choisir le département -->
        <div class="container text-center py-3 ">
            <form method="post" class="form-inline">
                <div class="col-md-7">
                    <label class="my-1 mr-2" for="monselect">Choisir un département</label>
                    <select name="department" id="monselect" class="custom-select my-1 mr-sm-2">

                        <?php

                        $bdd = new PDO('mysql:host=localhost;dbname=bigdata;charset=utf8','root','');
                         $locations=array();
     

                        $req = $bdd->query("SELECT distinct department_id, name_department  FROM department ");
                        $req->execute();

                        while ($row = $req->fetch()){
                        $name_dep_full = $row['name_department'];
                        $name_dep = $row['department_id'];
                        $name_dep = substr($name_dep, -5,2);

                        ?>   
                        <option class="" value="<?= $name_dep?>"><?= $name_dep?> - <?= $name_dep_full?></option> 
                        <?php
                            }
                        ?>
                    </select>
                </div>            
                <!-- Formulaire pour choisir le département -->
                <div class="col-md-4">
                    <label class="my-1 mr-2" for="monselect2">Choisir un type d'établissement</label>
                    <select name="type_value"  id="monselect2" class="custom-select my-1 mr-sm-2">
                        <?php
                        $bdd = new PDO('mysql:host=localhost;dbname=bigdata;charset=utf8','root','');
                        $locations=array();
                         

                        $req = $bdd->query("SELECT distinct description, type_id FROM type   ");
                        $req->execute();

                        while ($row = $req->fetch()){
                        $name_type = $row['description'];
                        $name_id = $row['type_id'];



                        ?>           
                    <option class="" value="<?= $name_id?>"><?= $name_type?></option> 

                    <?php

                        /* Each row is added as a new array */
                        }
                    ?>
                    </select>
                </div>
                <input type="submit" class="btn btn-primary bouton">
            </form>
            <hr>

      </div>
                <?php
                if(isset($_POST['department']) OR isset($_POST['type_value'])) {
                    $department_value = $_POST['department']."%";
                    $type_value = $_POST['type_value'];

                    $bdd = new PDO('mysql:host=localhost;dbname=bigdata;charset=utf8','root','');
                    $locations=array();
                     
                    /*Requête pour afficher les établissements*/
                    $req = $bdd->query("SELECT  * 
                                        FROM location 
                                        INNER JOIN type ON location.type_id = type.type_id
                                        INNER JOIN department ON location.department_id = department.department_id 
                                        WHERE department.department_id LIKE '$department_value' AND type.type_id = '$type_value'");
                    $req->execute();
                    /*Boucle pour afficher les marqeurs de positions sur la carte*/
                    while ($row = $req->fetch()){
                        $markeur = $row['name'];
                        $longitude = $row['longitude'];                              
                        $latitude = $row['latitude'];
                        $link=$row['link'];
                        $locations[]=array( 'name'=>$markeur, 'lat'=>$latitude, 'lng'=>$longitude, 'lnk'=>$link );
                    }
                }
                ?>

                <div id="map-canvas" class="container col-12"  ></div>



     <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key= AIzaSyCzQIMRbc-xeXj3O8qbMNmngsxVsrShHRE "></script> 
     <script src="https://code.jquery.com/jquery-1.12.0.min.js"></script>
    <!--  <script type="text/javascript" src="js/map.js"></script> -->
     <script type="text/javascript">



            var map;
            var Markers = {};
            var infowindow;
            var locations = [
                <?php for($i=0;$i<sizeof($locations);$i++){ $j=$i+1;?>
                [
                    'AMC Service',   
                    '<p><a href="<?php echo $locations[$i]['lnk'] ;?>">Visite lecole</a></p>',
                    <?php echo $locations[$i]['lat'];?>,
                    <?php echo $locations[$i]['lng'];?>,
                    
                ]<?php if($j!=sizeof($locations))echo ","; }?>
            ];
            var origin = new google.maps.LatLng(locations[0][2], locations[0][3]);
            function initialize() {
              var mapOptions = {
                zoom: 7,
                center: origin
              };


              map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);
                infowindow = new google.maps.InfoWindow();
                for(i=0; i<locations.length; i++) {
                    var position = new google.maps.LatLng(locations[i][2], locations[i][3]);
                    var marker = new google.maps.Marker({
                        position: position,
                        map: map,
                    });
                    google.maps.event.addListener(marker, 'click', (function(marker, i) {
                        return function() {
                            infowindow.setContent(locations[i][1]);
                            infowindow.setOptions({maxWidth: 200});
                            infowindow.open(map, marker);
                        }
                    }) (marker, i));
                    Markers[locations[i][4]] = marker;
                }
                locate(0);
            }

            function locate(marker_id) {
                var myMarker = Markers[marker_id];
                var markerPosition = myMarker.getPosition();
                map.setCenter(markerPosition);
                google.maps.event.trigger(myMarker, 'click');
            }
            google.maps.event.addDomListener(window, 'load', initialize);
     </script>
 </body>
 </html>