-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47x (Handle)
-- Notes: Opens door _477
-- !pos -99 -71 -41 151
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local brassDoor = GetNPCByID(npc:getID() - 1)

    if
        player:getZPos() > -45 and
        npc:getAnimation() == xi.anim.CLOSE_DOOR and
        brassDoor:getAnimation() == xi.anim.CLOSE_DOOR
    then
        npc:openDoor(6.5)
        -- Should be a ~1 second delay here before the door opens
        brassDoor:openDoor(4.5)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
