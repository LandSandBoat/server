-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: _0rb (Iron Gate)
-- !pos 180.000 -25.500 48.450 27
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == 9 then
        npc:openDoor()
    end
end

return entity
