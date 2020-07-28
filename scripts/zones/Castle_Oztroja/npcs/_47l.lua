-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47l (Torch Stand)
-- Notes: Opens door _471 near password #3
-- !pos -45.228 -17.832 22.392 151
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
require("scripts/globals/status")
-----------------------------------

function onTrigger(player, npc)
    local brassDoor = GetNPCByID(npc:getID() - 4)

    if npc:getAnimation() == tpz.anim.CLOSE_DOOR and brassDoor:getAnimation() == tpz.anim.CLOSE_DOOR then
        player:startEvent(10)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    local brassDoor = GetNPCByID(ID.npc.SECOND_PASSWORD_STATUE - 2)
    local torch1 = GetNPCByID(ID.npc.SECOND_PASSWORD_STATUE + 1)
    local torch2 = GetNPCByID(ID.npc.SECOND_PASSWORD_STATUE + 2)

    if option == 1 then
        torch1:openDoor(10)
        torch2:openDoor(10)
        brassDoor:openDoor(6)
    end
end
