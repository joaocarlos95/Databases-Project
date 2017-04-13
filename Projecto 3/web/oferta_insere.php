<html>
    <body>
        <h3>Cria nova oferta</h3>
        <form action="oferta_update.php" method="post">
            <p>Morada do alugavel da oferta: <?php echo ($_REQUEST['morada']); ?><input type="hidden" name="morada" value="<?php echo ($_REQUEST['morada']); ?>"/></p>
            <p>Codigo do alugavel da oferta: <?php echo ($_REQUEST['codigo']); ?><input type="hidden" name="codigo" value="<?php echo ($_REQUEST['codigo']); ?>"/></p>
            <p>Data de inicio: <input type="text" name="data_inicio"/></p>
            <p>Data de fim: <input type="text" name="data_fim"/></p>
            <p>Tarifa diaria: <input type="text" name="tarifa"/></p>
            <p><input type="submit" value="Submit"/></p>
        </form>
    </body>
</html>