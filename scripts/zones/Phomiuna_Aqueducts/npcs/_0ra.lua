-----------------------------------
-- Area: Phomiuna_Aqueducts
--  NPC: _0ra (Iron Gate)
-- !pos 180.000 -25.500 71.400 27
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if npc:getAnimation() == 9 then
        npc:openDoor()
    end
end

return entity
