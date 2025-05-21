-----------------------------------
-- Area: The Eldieme Necropolis
--  NPC: Gravestone
-- Involved in Quests: fire and brimstone (Rng AF2)
-- !zone 195
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCharVar('fireAndBrimstone') == 3 then
        player:startEvent(5)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 5 then
        player:setCharVar('fireAndBrimstone', 4)
    end
end

return entity
