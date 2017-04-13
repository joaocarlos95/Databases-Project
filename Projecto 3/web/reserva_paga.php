<html>
    <body>
        <h3>Pagar a reserva</h3>
        <form action="reserva_paga_update.php" method="post">
            <p>Numero da reserva: <input type="hidden" name="numero" value="<?php echo ($_REQUEST['numero']); ?>"/></p>
            <p>Data: <input type="text" name="data"/></p>
            <p>Metodo: <input type="text" name="metodo"/></p>
            <p><input type="submit" value="Submit"/></p>
        </form>
    </body>
</html>