-----------------------------------
-- Area: Sacrarium
--  NPC: _0s4 (Wooden Gate)
-- !pos 20.000 -3.500 -97.370 28
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == 9 then
        npc:openDoor()
    end
end

return entity
