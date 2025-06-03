-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: _0r8 (Ornate Gate)
-- !pos 129.500 -25.500 60.000 27
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == 9 then
        npc:openDoor()
    end
end

return entity
