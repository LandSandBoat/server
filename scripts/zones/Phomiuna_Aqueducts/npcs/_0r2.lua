-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: _0r2 (Wooden Gate)
-- !pos -140.000 -25.500 49.000 27
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == 9 then
        npc:openDoor()
    end
end

return entity
