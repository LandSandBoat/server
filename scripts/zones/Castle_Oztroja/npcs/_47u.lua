-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47u (Handle)
-- Notes: Opens door _474 from behind
-- !pos -60 24 -77 151
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local brassDoor = GetNPCByID(npc:getID() - 1)

    if
        player:getZPos() < -72 and
        npc:getAnimation() == xi.anim.CLOSE_DOOR and
        brassDoor and
        brassDoor:getAnimation() == xi.anim.CLOSE_DOOR
    then
        npc:openDoor(6.5)
        -- Should be a ~1 second delay here before the door opens
        brassDoor:openDoor(4.5)
    end
end

return entity
