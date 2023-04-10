-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47m (Torch Stand)
-- Notes: Opens door _471 near password #3
-- !pos -45.230 -17.832 17.668 151
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
require("scripts/globals/status")
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
    local brassDoor = GetNPCByID(ID.npc.SECOND_PASSWORD_STATUE - 2)
    local torch1 = GetNPCByID(ID.npc.SECOND_PASSWORD_STATUE + 1)
    local torch2 = GetNPCByID(ID.npc.SECOND_PASSWORD_STATUE + 2)

    if option == 1 then
        torch1:openDoor(10)
        torch2:openDoor(10)
        brassDoor:openDoor(6)
    end
end

return entity
