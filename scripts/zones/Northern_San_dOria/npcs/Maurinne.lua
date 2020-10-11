-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Maurinne
-- !pos -127.185 0.000 179.193 231
-----------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("thePickpocket") == 1 then
        player:showText(npc, ID.text.PICKPOCKET_MAURINNE)
        player:showText(npc, ID.text.PICKPOCKET_MAURINNE + 1)
    else
        player:showText(npc, ID.text.MAURINNE_DIALOG)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
