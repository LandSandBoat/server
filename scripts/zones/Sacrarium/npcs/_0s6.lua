-----------------------------------
-- Area: Sacrarium
--  NPC: _0s6 (Wooden Gate)
-- !pos 213.375 -3.499 20.000 28
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == 9 then
        npc:openDoor()
    end
end

return entity
