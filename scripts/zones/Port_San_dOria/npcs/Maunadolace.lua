-----------------------------------
-- Area: Port San d'Oria
--  NPC: Maunadolace
-- Type: Standard NPC
-- !pos -22.800 -9.3 -148.645 232
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getCharVar("thePickpocket") == 1 then
        player:showText(npc, ID.text.PICKPOCKET_MAUNADOLACE)
    else
        player:startEvent(713)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
