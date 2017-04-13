<html>
    <body>
        <h3>Cria nova reserva</h3>
        <form action="reserva_update.php" method="post">
            <p>Morada da oferta da reserva: <?php echo ($_REQUEST['morada']); ?><input type="hidden" name="morada" value="<?php echo ($_REQUEST['morada']); ?>"/></p>
            <p>Codigo da oferta da reserva: <?php echo ($_REQUEST['codigo']); ?><input type="hidden" name="codigo" value="<?php echo ($_REQUEST['codigo']); ?>"/></p>
            <p>Data de inicio da oferta da reserva: <?php echo ($_REQUEST['data_inicio']); ?><input type="hidden" name="data_inicio" value="<?php echo ($_REQUEST['data_inicio']); ?>"/></p> 
            <p>NIF: <input type="text" name="nif"/></p>
            <p><input type="submit" value="Submit"/></p>
        </form>
    </body>
</html>