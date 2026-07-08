-----------------------------------
-- Area: Ro'Maeve
--  NPC: _3e1 (Moongate)
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:hasKeyItem(xi.ki.MOONGATE_PASS) then
        npc:openDoor(10)
    end
end

return entity
