local ID = require("scripts/zones/Northern_San_dOria/IDs")

return {

    ['Abeaule']       = { text = ID.text.ABEAULE_DIALOG_THANKS },
    ['Abioleget']     = { text = ID.text.ABIOLEGET_DIALOG },
    ['Ailbeche']      = { event = 868 },
    ['Aivedoir']      = { text = ID.text.AIVEDOIR_DIALOG },
    ['Arienh']        = { text = ID.text.ARIENH_DIALOG },
    ['Bacherume']     = { text = ID.text.BACHERUME_DIALOG },
    ['Belgidiveau']   = { event = 585 },
    ['Charlaimagnat'] = { event = 702 },
    ['Chasalvige']    = { event = 6 },
    ['Emilia']        = { text = ID.text.EMILIA_DIALOG },
    ['Eperdur']       = { event = 678 },
    ['Fittesegat']    = { text = ID.text.FITTESEGAT_DIALOG },
    ['Gilipese']      =
    {
        onTrigger = function(player, npc)
            if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
                local npcID = npc:getID()
                local sender = player:getCharVar("[MerryMakers]Sender")
                local confirmed = player:getCharVar("[MerryMakers]Confirmed")

                if npcID == sender or npcID == confirmed then
                    xi.events.starlightCelebration.merryMakersNPCDeliverOnTrigger(player, npc, ID)
                    return
                end
            end

            player:showText(npc, ID.text.GILIPESE_DIALOG)
        end,
    },
    ['Guilerme']   = { text = ID.text.GUILERME_DIALOG },
    ['Helaku']     = { event = 541 },
    ['Hinaree']    = { event = 580 },
    ['Ishwar']     = { text = ID.text.ISHWAR_DIALOG },
    ['Kasaroro']   = { event = 548 },
    ['Malfine']    = { text = ID.text.MALFINE_DIALOG },
    ['Maloquedil'] = { event = 21 },
    ['Maurine']    = { text = ID.text.MAURINE_DIALOG },  -- NOTE: These are two different NPCs
    ['Maurinne']   = { text = ID.text.MAURINNE_DIALOG },
    ['Miaux']      = { event = 517 },
    ['Morjean']    = { event = 601 },
    ['Miageau']    = { event = 517 },
    ['Narcheral']  = { event = 688 },
    ['Nouveil']    = { event = 574 },
    ['Olbergieut'] = { event = 612 },
    ['Pellimie']   = { text = ID.text.PELLIMIE_DIALOG },
    ['Pepigort']   = { text = ID.text.PEPIGORT_DIALOG },
    ['Phaviane']   = { text = ID.text.PHAVIANE_DIALOG },
    ['Prerivon']   = { text = ID.text.PRERIVON_DIALOG },
    ['Rodaillece'] =
    {
        onTrigger = function(player, npc)
            if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
                local npcID = npc:getID()
                local sender = player:getCharVar("[MerryMakers]Sender")
                local confirmed = player:getCharVar("[MerryMakers]Confirmed")

                if npcID == sender or npcID == confirmed then
                    xi.events.starlightCelebration.merryMakersNPCDeliverOnTrigger(player, npc, ID)
                    return
                end
            end

            player:showText(npc, ID.text.RODAILLECE_DIALOG)
        end,
    },
    ['Sochiene']     = { text = ID.text.SOCHIENE_DIALOG },
    ['Vamorcote']    = { event = 651 },
}
