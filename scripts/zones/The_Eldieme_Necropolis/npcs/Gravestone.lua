-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: Gravestone
-- Involved in Quests: fire and brimstone (Rng AF2)
-- !zone 195
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getCharVar('fireAndBrimstone') == 3 then
        player:startEvent(5)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 5 then
        player:setCharVar('fireAndBrimstone', 4)
    end
end

return entity
