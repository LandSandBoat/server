-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47k (Torch Stand)
-- Notes: Opens door _472 near password #1
-- !pos -57.412 -1.864 -30.627 151
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local brassDoor = GetNPCByID(npc:getID() - 3)

    if
        npc:getAnimation() == xi.anim.CLOSE_DOOR and
        brassDoor:getAnimation() == xi.anim.CLOSE_DOOR
    then
        player:startEvent(10)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    local brassDoor = GetNPCByID(ID.npc.FIRST_PASSWORD_STATUE - 2)
    local torch1 = GetNPCByID(ID.npc.FIRST_PASSWORD_STATUE + 1)
    local torch2 = GetNPCByID(ID.npc.FIRST_PASSWORD_STATUE + 2)

    if option == 1 then
        torch1:openDoor(10)
        torch2:openDoor(10)
        brassDoor:openDoor(6)
    end
end

return entity
