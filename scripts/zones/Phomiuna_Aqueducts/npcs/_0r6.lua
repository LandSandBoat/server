-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: _0r6 (Wooden Gate)
-- !pos 118.625 -25.500 100.000 27
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == 9 then
        npc:openDoor()
    end
end

return entity
