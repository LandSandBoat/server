-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ailevia
-- Adventurer's Assistant
-- Only recieving Adv.Coupon and simple talk event are scripted
-- This NPC participates in Quests and Missions
-- !pos -8 1 1 230
-----------------------------------
local ID = require("scripts/zones/Southern_San_dOria/IDs")
require("scripts/settings/main")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    -- Adventurer coupon
    if (trade:getItemCount() == 1 and trade:hasItemQty(536, 1) == true) then
        player:startEvent(655)
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(615) -- i know a thing or 2 about these streets
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if (csid == 655) then
        player:addGil(xi.settings.GIL_RATE*50)
        player:tradeComplete()
        player:messageSpecial(ID.text.GIL_OBTAINED, xi.settings.GIL_RATE*50)
    end
end

return entity
