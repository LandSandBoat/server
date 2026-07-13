-----------------------------------
-- Area: Port Windurst
--  NPC: Three of Clubs
-- !pos -7.238 -5 106.982 240
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(222)
end

return entity
