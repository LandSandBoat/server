-----------------------------------
-- Area: Sacrarium
--  NPC: _0s7 (Wooden Gate)
-- !pos 213.375 -3.500 -20.000 28
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == 9 then
        npc:openDoor()
    end
end

return entity
