<?php
try{
    $connection = new PDO('mysql:host=localhost,dbname=id15367504_condoregister','id15367504_taozhe','WongTaoZhe@1234');
    $connection ->setAttribute(PDO::ATTR_ERRMODE,PDO::ERRMODE_EXCEPTION);
    echo "yes Connected";
}catch(PDOException $exc){
    echo $exc->getMessage();
    die("could not connect");
}
?>