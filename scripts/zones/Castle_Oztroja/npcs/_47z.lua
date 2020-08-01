-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47z (Torch Stand)
-- Notes: Opens door _474
-- !pos -62.464 24.218 -67.313 151
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
    local brassDoor = GetNPCByID(ID.npc.THIRD_PASSWORD_STATUE - 2)
    local torch1 = GetNPCByID(ID.npc.THIRD_PASSWORD_STATUE + 1)
    local torch2 = GetNPCByID(ID.npc.THIRD_PASSWORD_STATUE + 2)

    if option == 1 then
        torch1:openDoor(10)
        torch2:openDoor(10)
        brassDoor:openDoor(6)
    end

end
