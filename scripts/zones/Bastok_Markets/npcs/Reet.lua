-----------------------------------
-- Area: Bastok Markets
--  NPC: Reet
-- Adventurer's Assistant
-- !pos -237 -12 -41 235
-------------------------------------
local ID = require("scripts/zones/Bastok_Markets/IDs")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
    if (trade:getItemCount() == 1 and trade:hasItemQty(536, 1) == true) then
        player:startEvent(6)
    end
end

function onTrigger(player, npc)
    player:startEvent(5)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 6) then
        player:tradeComplete()
        player:addGil(GIL_RATE*50)
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*50)
    end
end
