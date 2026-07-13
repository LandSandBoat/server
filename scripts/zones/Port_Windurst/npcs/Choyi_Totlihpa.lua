-----------------------------------
-- Area: Port Windurst
--  NPC: Choyi Totlihpa
-- !pos -58.927 -5.732 132.819 240
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(215)
end

return entity
