-----------------------------------
-- Area: Port Windurst
--  NPC: Jack of Clubs
-- Adventurer's Assistant
-- Working 100%
-------------------------------------
require("scripts/globals/settings")

function onTrade(player, npc, trade)
    if (trade:getItemCount() == 1 and trade:hasItemQty(536, 1) == true) then
        player:startEvent(10008, GIL_RATE*50)
        player:addGil(GIL_RATE*50)
        player:tradeComplete()
    end
end

function onTrigger(player, npc)
    player:startEvent(10007, 0, 3)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
