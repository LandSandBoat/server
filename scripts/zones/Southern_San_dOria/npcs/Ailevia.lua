-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ailevia
-- Adventurer's Assistant
-- Only recieving Adv.Coupon and simple talk event are scripted
-- This NPC participates in Quests and Missions
-- !pos -8 1 1 230
-------------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/globals/settings")
-----------------------------------

function onTrade(player, npc, trade)
    -- Adventurer coupon
    if (trade:getItemCount() == 1 and trade:hasItemQty(536, 1) == true) then
        player:startEvent(655)
    end
end

function onTrigger(player, npc)
    player:startEvent(615) -- i know a thing or 2 about these streets
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 655) then
        player:addGil(GIL_RATE*50)
        player:tradeComplete()
        player:messageSpecial(ID.text.GIL_OBTAINED, GIL_RATE*50)
    end
end
