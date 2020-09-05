-----------------------------------
-- Area: Port San d'Oria
--  NPC: Laucimercen
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("thePickpocket") == 1 then
        player:showText(npc, ID.text.PICKPOCKET_LAUCIMERCEN)
    else
        player:startEvent(563)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
