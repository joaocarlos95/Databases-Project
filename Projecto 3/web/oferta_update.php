<html>
    <body>
<?php
    $morada = $_REQUEST['morada'];
    $codigo = $_REQUEST['codigo'];
    $data_inicio = $_REQUEST['data_inicio'];
    $data_fim = $_REQUEST['data_fim'];
    $tarifa = $_REQUEST['tarifa'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist181950";
        $password = "evlw3510";
        $dbname = $user;
        $db = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $db->query("start transaction;");

        echo ((bool)strtotime($data_inicio));

        if ((filter_var($_POST['tarifa'], FILTER_VALIDATE_FLOAT)) && (bool)strtotime($data_inicio) && (bool)strtotime($data_fim)) {
            $sql = "INSERT INTO oferta VALUES ('$morada', '$codigo', '$data_inicio', '$data_fim', '$tarifa');";
            
            echo("<p>$sql</p>");

            $db->query($sql);
        }


        $db->query("commit;");

        $db = null;
    }
    catch (PDOException $e)
    {
        $db->query("rollback;");
        echo("<p>ERROR: {$e->getMessage()}</p>");
    }
?>
    </body>
</html>
