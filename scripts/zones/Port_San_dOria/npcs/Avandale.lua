-----------------------------------
-- Area: Port San d'Oria
--  NPC: Avandale
-- !pos -105.524 -9 -125.274 232
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("thePickpocket") == 1 then
        player:showText(npc, ID.text.PICKPOCKET_AVANDALE)
    else
        player:startEvent(555)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
