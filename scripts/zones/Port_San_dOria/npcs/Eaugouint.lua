-----------------------------------
-- Area: Port San d'Oria
--  NPC: Eaugouint
-- !pos 28.555 -4.000 -74.860 232
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("thePickpocket") == 1 then
        player:showText(npc, ID.text.PICKPOCKET_EAUGOUINT)
    else
        player:startEvent(579)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
