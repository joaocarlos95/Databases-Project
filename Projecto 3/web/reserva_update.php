<html>
    <body>
<?php
    $morada = $_REQUEST['morada'];
    $codigo = $_REQUEST['codigo'];
    $data_inicio = $_REQUEST['data_inicio'];
    $nif = $_REQUEST['nif'];
    try
    {
        $host = "db.ist.utl.pt";
        $user ="ist181950";
        $password = "evlw3510";
        $dbname = $user;
        $db = new PDO("mysql:host=$host;dbname=$dbname", $user, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $db->query("start transaction;");

        $sql1 = "SELECT MAX(numero)+1 FROM reserva;";
        $result = $db->query($sql1);

        foreach($result as $row){
            $nmax =($row[0]);
        }

        $sql = "INSERT INTO reserva VALUES ('$nmax');";
        $sql2 = "INSERT INTO aluga VALUES ('$morada', '$codigo', '$data_inicio', '$nif', '$nmax');";
        $sql3 = "INSERT INTO estado VALUES ('$nmax', '$data_inicio', 'Pendente'); ";

        echo("<p>$sql</p>");
        echo("<p>$sql2</p>");
        echo("<p>$sql3</p>");

        $db->query($sql);
        $db->query($sql2);
        $db->query($sql3);

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
