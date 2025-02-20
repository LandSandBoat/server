-----------------------------------
-- Area: Sacrarium
--  NPC: _0s0 (Iron Gate)
-- !pos -35.026 -3.000 -9.997 28
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == 9 then
        npc:openDoor()
    end
end

return entity
