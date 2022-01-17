-----------------------------------
-- Area: Giddeus
--  NPC: Quu Bokye
-- Involved in Quest: Dark Legacy
-- !pos -159 16 181 145
-----------------------------------
local ID = require("scripts/zones/Giddeus/IDs")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if player:getCharVar("darkLegacyCS") == 3 and trade:hasItemQty(4445, 1) and trade:getItemCount() == 1 then -- Trade Yagudo Cherries
        player:startEvent(62)
    end
end

entity.onTrigger = function(player, npc)
    if player:getCharVar("darkLegacyCS") == 3 then
        player:startEvent(61)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 62 then
        player:tradeComplete()
        player:setCharVar("darkLegacyCS", 4)
    end
end

return entity
