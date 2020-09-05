-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47w (Handle)
-- Notes: Opens door _473 from behind
-- !pos -41.377 -17.084 17.036 151
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onTrigger(player, npc)
    local brassDoor = GetNPCByID(npc:getID() - 1)

    if player:getXPos() > -43 and npc:getAnimation() == tpz.anim.CLOSE_DOOR and brassDoor:getAnimation() == tpz.anim.CLOSE_DOOR then
        npc:openDoor(6.5)
        -- Should be a ~1 second delay here before the door opens
        brassDoor:openDoor(4.5)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
