-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: _0r0 (Iron Gate)
-- !pos -140.000 -25.500 71.213 27
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == 9 then
        npc:openDoor()
    end
end

return entity
