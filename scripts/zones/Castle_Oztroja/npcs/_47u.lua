-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47u (Handle)
-- Notes: Opens door _474 from behind
-- !pos -60 24 -77 151
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onTrigger(player, npc)
    local brassDoor = GetNPCByID(npc:getID() - 1)

    if player:getZPos() < -72 and npc:getAnimation() == tpz.anim.CLOSE_DOOR and brassDoor:getAnimation() == tpz.anim.CLOSE_DOOR then
        npc:openDoor(6.5)
        -- Should be a ~1 second delay here before the door opens
        brassDoor:openDoor(4.5)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
