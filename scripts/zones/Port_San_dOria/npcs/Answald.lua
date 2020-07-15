-----------------------------------
-- Area: Port San d'Oria
--  NPC: Answald
-----------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/quests/flyers_for_regine")
-----------------------------------

function onTrade(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 0) -- FLYERS FOR REGINE
end

function onTrigger(player, npc)
    if player:getCharVar("thePickpocket") == 1 then
        player:showText(npc, ID.text.PICKPOCKET_ANSWALD)
    else
        player:startEvent(584)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
