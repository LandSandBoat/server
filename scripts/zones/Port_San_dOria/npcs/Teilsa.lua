-----------------------------------
-- Area: Port San d'Oria
--  NPC: Teilsa
-- Adventurer's Assistant
-- Only recieving Adv.Coupon and simple talk event are scrited
-- This NPC participates in Quests and Missions
-------------------------------------
local ID = require("scripts/zones/Port_San_dOria/IDs")
require("scripts/globals/settings")
-------------------------------------

function onTrade(player, npc, trade)
    if (trade:getItemCount() == 1 and trade:hasItemQty(536, 1) == true) then
        player:startEvent(612)
        player:addGil(GIL_RATE*50)
        player:tradeComplete()
    end
end

function onTrigger(player, npc)
    player:startEvent(573)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 612) then
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*50)
    end
end
