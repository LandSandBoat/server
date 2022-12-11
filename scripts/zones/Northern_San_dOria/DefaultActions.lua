local ID = require("scripts/zones/Northern_San_dOria/IDs")

return {
    ['Abeaule']    = { text = ID.text.ABEAULE_DIALOG_THANKS },
    ['Ailbeche']   = { event = 868 },
    ['Bacherume']  = { text = ID.text.BACHERUME_DIALOG },
    ['Chasalvige'] = { event = 6 },
    ['Eperdur']    = { event = 678 },
    ['Gilipese']   =
    {
        onTrigger = function(player, npc)
            if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
                local npcID = npc:getID()
                local sender = player:getLocalVar("[StarlightMerryMakers]Sender")
                local confirmed = player:getLocalVar("[StarlightMerryMakers]Confirmed")

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
    ['Kasaroro']   = { event = 548 },
    ['Maurinne']   = { text = ID.text.MAURINNE_DIALOG },
    ['Miageau']    = { event = 517 },
    ['Nouveil']    = { event = 574 },
    ['Pepigort']   = { text = ID.text.PEPIGORT_DIALOG },
    ['Rodaillece'] =
    {
        onTrigger = function(player, npc)
            if xi.events.starlightCelebration.isStarlightEnabled() ~= 0 then
                local npcID = npc:getID()
                local sender = player:getLocalVar("[StarlightMerryMakers]Sender")
                local confirmed = player:getLocalVar("[StarlightMerryMakers]Confirmed")

                if npcID == sender or npcID == confirmed then
                    xi.events.starlightCelebration.merryMakersNPCDeliverOnTrigger(player, npc, ID)
                    return
                end
            end
            player:showText(npc, ID.text.RODAILLECE_DIALOG)
        end,
    },
}
