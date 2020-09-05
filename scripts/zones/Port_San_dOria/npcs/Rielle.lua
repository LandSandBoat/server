-----------------------------------
-- Area: Port San d'Oria
--  NPC: Rielle
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("thePickpocket") == 1 then
        player:showText(npc, ID.text.PICKPOCKET_RIELLE)
    else
        player:startEvent(564)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
