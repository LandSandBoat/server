-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Matildie
-- Adventurer's Assistant
-------------------------------------
local ID = require("scripts/zones/Northern_San_dOria/IDs")
require("scripts/globals/settings")
-------------------------------------

function onTrade(player, npc, trade)
    if (trade:getItemCount() == 1 and trade:hasItemQty(536, 1) == true) then
        player:startEvent(631)
        player:addGil(GIL_RATE*50)
        player:tradeComplete()
    end
end

function onTrigger(player, npc)
    player:startEvent(587)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 631) then
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*50)
    end
end
