-----------------------------------
-- Area: Chamber of Oracles
--  NPC: Cermet Door (Exit)
-- Involved in Zilart Mission 7
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.PRISMATIC_FRAGMENT) then
        player:startEvent(2, xi.ki.PRISMATIC_FRAGMENT, 300, 200, 100, 168)
    end
end

return entity
