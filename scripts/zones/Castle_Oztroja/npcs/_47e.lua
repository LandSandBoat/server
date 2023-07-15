-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47e (Handle)
-- Notes: Opens _470 (Brass Door) from behind
-- !pos 22.905 -1.087 -8.003 151
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local brassDoor = GetNPCByID(npc:getID() - 4)

    if
        player:getZPos() > -11.9 and
        npc:getAnimation() == xi.anim.CLOSE_DOOR and
        brassDoor:getAnimation() == xi.anim.CLOSE_DOOR
    then
        npc:openDoor(6.5)
        -- Should be a ~1 second delay here before the door opens
        brassDoor:openDoor(4.5)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
