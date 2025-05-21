-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47k (Torch Stand)
-- Notes: Opens door _472 near password #1
-- !pos -57.412 -1.864 -30.627 151
-----------------------------------
local ID = zones[xi.zone.CASTLE_OZTROJA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local brassDoor = GetNPCByID(npc:getID() - 3)

    if
        npc:getAnimation() == xi.anim.CLOSE_DOOR and
        brassDoor and
        brassDoor:getAnimation() == xi.anim.CLOSE_DOOR
    then
        player:startEvent(10)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local brassDoor = GetNPCByID(ID.npc.FIRST_PASSWORD_STATUE - 2)
    local torch1 = GetNPCByID(ID.npc.FIRST_PASSWORD_STATUE + 1)
    local torch2 = GetNPCByID(ID.npc.FIRST_PASSWORD_STATUE + 2)

    if
        torch1 and
        torch2 and
        brassDoor and
        option == 1
    then
        torch1:openDoor(10)
        torch2:openDoor(10)
        brassDoor:openDoor(6)
    end
end

return entity
