-----------------------------------
-- Area: Port San d'Oria
--  NPC: Solgierte
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("thePickpocket") == 1 then
        player:showText(npc, ID.text.PICKPOCKET_SOLGIERTE)
    else
        player:startEvent(567)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
