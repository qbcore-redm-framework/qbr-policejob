local Translations = {
    error = {
        license_already = 'El jugador ya tiene una licencia',
        error_license = 'El reproductor no tiene esa licencia',
        no_camera = 'La cámara no existe',
        blood_not_cleared = 'Sangre NO limpia',
        bullet_casing_not_removed = 'Casquillos de bala NO retirados',
        none_nearby = '¡No hay nadie cerca!',
        canceled  = 'Cancelado..',
        time_higher = 'El tiempo debe ser mayor que 0',
        amount_higher  = 'La cantidad debe ser mayor que 0',
        vehicle_cuff = 'No puedes esposar a alguien en un vehículo',
        no_cuff = 'No tienes esposas',
        no_impound = 'No hay vehículos incautados',
        no_spikestripe = 'No se pueden colocar más tiras de púas',
        error_license_type = 'Tipo de licencia no válido',
        rank_license = 'No tienes un rango lo suficientemente alto como para otorgar una licencia',
        revoked_license = 'Se le ha revocado una licencia',
        rank_revoke = 'No tienes un rango lo suficientemente alto como para revocar una licencia',
        on_duty_police_only = 'Sólo para policías de servicio',
        vehicle_not_flag = 'Vehículo no marcado',
        not_towdriver = 'No soy conductor de grúa',
        not_lawyer = 'La persona no es abogado',
        no_anklet = 'Esta persona no tiene tobillera.',
        have_evidence_bag = 'Debes llevar contigo una bolsa de pruebas vacía',
        no_driver_license = 'Sin licencia de conducir',
        not_cuffed_dead = 'El civil no está esposado ni muerto',
    },
    success = {
        uncuffed = 'Te han quitado las esposas',
        granted_license  = 'Se le ha concedido una licencia',
        grant_license = 'Usted concedió una licencia',
        revoke_license = 'Usted revocó una licencia',
        tow_paid = 'Le pagaron $500',
        blood_clear = 'Sangre limpia',
        bala_casing_removed = 'Casquillos de bala retirados...',
        anklet_taken_off = 'Te quitaron el rastreador de tobillo.',
        take_anklet_from = 'Quitaste el rastreador %{firstname} %{lastname}',
        put_anklet = 'Te pusiste un rastreador de tobillo.',
        put_anklet_on = 'Te pusiste un rastreador de tobillo en %{firstname} %{lastname}',
        vehicle_flagged = 'El vehículo %{plate} ha sido marcado por %{reason}',
        impound_vehicle_removed = '¡Vehículo sacado del depósito!',
    },
    info = {
        mr = 'Sr.',
        mrs = 'Sta.',
        impound_price = 'Precio que el jugador paga para sacar el vehículo del depósito (puede ser 0)',
        plate_number = 'Número de matrícula',
        flag_reason = 'Motivo para marcar el vehículo',
        camera_id = 'ID de cámara',
        callsign_name = 'Nombre de tu indicativo',
        poobject_object = 'Tipo de objeto para generar o \'eliminar\' para eliminar',
        player_id = 'ID del jugador',
        citizen_id = 'ID de ciudadano del jugador',
        dna_sample = 'Muestra de ADN',
        jail_time = 'Tiempo que tienen para estar en la cárcel',
        jail_time_no = 'El tiempo de cárcel debe ser superior a 0',
        license_type = 'Tipo de licencia (conductor/arma)',
        ankle_location = 'Ubicación del rastreador de tobillo',
        cuff  = '¡Estás esposado!',
        cuffed_walk = 'Estás esposado, pero puedes caminar',
        vehicle_flagged = 'El vehículo %{vehicle} está marcado por: %{reason}',
        unflag_vehicle = 'El vehículo %{vehicle} no está marcado',
        tow_driver_paid = 'Le pagaste al conductor de la grúa',
        paid_lawyer = 'Le pagaste a un abogado',
        vehicle_taken_depot = 'Vehículo llevado al depósito por $%{price}',
        vehicle_seized  = 'Vehículo incautado',
        stolen_money  = 'Has robado $%{stolen}',
        cash_robbed = 'Te han robado $%{money}',
        driver_license_confiscated = 'Su permiso de conducir ha sido confiscado',
        cash_confiscated = 'Su efectivo fue confiscado',
        being_searched = 'Estás siendo buscado',
        cash_found = 'Encontrado $%{cash} en el civil',
        sent_jail_for = 'Enviaste a la persona a prisión por %{time} meses',
        fine_received = 'Recibiste una multa de $%{fine}',
        blip_text = 'Alerta de policía - %{text}',
        jail_time_input = 'Tiempo de cárcel',
        submit = 'Enviar',
        time_months = 'Tiempo en meses',
        bill  = 'factura',
        amount  = 'Cantidad',
        police_plate  = 'LSPD', 
        vehicle_info  = 'Motor: %{value} % | Combustible: %{value2} %',
        evidencia_stash = 'Alijo de evidencia | %{value}',
        slot  = 'Nº de ranura. (1,2,3)',
        evidencia_actual = '%{value} | Cajón %{value2}',
        on_duty = '[~COLOR_YELLOWSTRONG~E~q~] - Ir de servicio',
        off_duty = '[~COLOR_YELLOWSTRONG~E~q~] - Fuera de servicio',
        onoff_duty = '~COLOR_YELLOWSTRONG~Activado~q~/~COLOR_YELLOWSTRONG~Desactivado~q~ Deber',
        stash  = 'alijo %{value}',
        delete_spike = '[~COLOR_YELLOWSTRONG~E~q~] Eliminar tira de púas',
        close_camera = 'Cerrar cámara',
        bullet_casing = '[~COLOR_YELLOWSTRONG~G~q~] Carcasa de bala %{value}',
        casing  = 'Carcasa de bala',
        blood  = 'Sangre',
        blood_text = '[~COLOR_YELLOWSTRONG~G~q~] ~COLOR_RED~Sangre %{value}',
        fingerprint_text  = '[~COLOR_YELLOWSTRONG~G~q~] Huella digital',
        fingerprint  = 'huella digital',
        store_heli = '[~COLOR_YELLOWSTRONG~E~q~] Almacenar helicóptero',
        take_heli = '[~COLOR_YELLOWSTRONG~E~q~] Tomar helicóptero',
        impound_veh = '[~COLOR_YELLOWSTRONG~E~q~] - Vehículo incautado',
        store_veh = '[~COLOR_YELLOWSTRONG~E~q~] - Almacenar vehículo',
        armory  = 'Armería',
        enter_armory = '[~COLOR_YELLOWSTRONG~E~q~] Armería',
        finger_scan = 'Escaneo de huellas dactilares',
        scan_fingerprint = '[~COLOR_YELLOWSTRONG~E~q~] Escanear huella digital',
        trash  = 'Papelera',
        trash_enter = '[~COLOR_YELLOWSTRONG~E~q~] Papelera',
        stash_enter = '[~COLOR_YELLOWSTRONG~E~q~] Entrar al casillero',
        target_location = 'La ubicación de %{firstname} %{lastname} está marcada en tu mapa',
        anklet_location = 'Ubicación de la tobillera',
        new_call = 'Nueva llamada',
        Officer_down = 'Oficial %{lastname} | %{callsign} Abajo'
    },
    evidence = {
        red_hands = 'Manos rojas',
        wide_pupils = 'pupilas anchas',
        red_eyes = 'Ojos rojos',
        weed_smell = 'Huele a hierba',
        gunpowder  = 'Pólvora en la ropa',
        chemicals  = 'huele a químico',
        heavy_breathing = 'Respira pesadamente',
        sudor = 'Suda mucho',
        handbleed = 'Sangre en las manos',
        confused  = 'Confundido',
        alcohol = 'Huele a alcohol',
        heavy_alcohol = 'Huele mucho a alcohol',
        agitated  = 'Agitado - Signos de uso de metanfetamina',
        serial_not_visible = 'Número de serie no visible...',
    },
    menu = {
        garage_title = 'Vehículos policiales',
        close  = '⬅ Cerrar menú',
        impound  = 'Vehículos incautados',
        pol_impound = 'Depósito policial',
        pol_garage = 'Garaje de la policía',
        pol_armory = 'Armería de la Policía',
    },
    email = {
        sender  = 'Agencia Central de Cobro Judicial',
        subject  = 'Cobro de deudas',
        message  = 'Estimado %{value}. %{value2}, <br /><br />La Agencia Central de Cobro Judicial (CJCA) cobró las multas que recibió de la policía.<br />Hay <strong>$%{value3}</strong> retirado de su cuenta.<br /><br />Saludos cordiales,<br />Sr. I.K. Graai',
    },
    commands = {
        place_spike = 'Colocar tira de púas (solo policía)',
        license_grant = 'Otorgar una licencia a alguien',
        license_revoke = 'Revocar una licencia de alguien',
        place_object = 'Colocar/eliminar un objeto (solo policía)',
        cuff_player = 'Jugador de esposas (solo policía)',
        escort  = 'Jugador de escolta',
        callsign  = 'Date un indicativo',
        clear_casign = 'Borrar área de casquillos (sólo policía)',
        jail_player = 'Jugador de la cárcel (solo policía)',
        unjail_player = 'Liberar jugador (solo policía)',
        clearblood = 'Limpiar el área de sangre (solo policía)',
        seizecash = 'Incautar efectivo (solo policía)',
        softcuff = 'Puño suave (solo policía)',
        camera  = 'Ver cámara de seguridad (solo policía)',
        flagplate = 'Placa de bandera A (solo policía)',
        unflagplate = 'Desmarcar una placa (solo policía)',
        plateinfo = 'Ejecutar una placa (solo policía)',
        depot  = 'Incautación con precio (solo policía)',
        impound  = 'Incautar un vehículo (solo policía)',
        paytow = 'Pagar al conductor del remolque (solo policía)',
        paylawyer = 'Pagar abogado (policía, juez únicamente)',
        anklet  = 'Adjuntar tobillera de seguimiento (solo policía)',
        ankletlocation = 'Obtener la ubicación de la tobillera de una persona',
        removeanklet = 'Eliminar tobillera de seguimiento (solo policía)',
        drivinglicense = 'Incautar licencia de conducir (solo policía)',
        takedna = 'Tomar una muestra de ADN de una persona (se necesita una bolsa de pruebas vacía) (Solo policía)',
        police_report = 'Informe policial',
        message_sent = 'Mensaje a enviar',
        civil_call = 'Llamada civil',
        emergency_call = 'Nueva llamada al 911',
    },
    progressbar = {
        blood_clear = 'Limpiando Sangre...',
        bala_casing = 'Retirando casquillos de bala..',
        robbing  = 'Persona robando...',
        place_object = 'Colocando objeto..',
        remove_object = 'Eliminando objeto..',
    },
    prompt = {
        toggle_duty_status = 'Alternar estado de servicio',
        open_evidence_stash = 'Abrir inventario de pruebas',
        open_personal_stash = 'Abrir inventario personal',
        open_armory = 'Abrir Armería',
    },
}

if GetConvar('qbr_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end