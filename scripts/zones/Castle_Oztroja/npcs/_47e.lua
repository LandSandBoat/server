-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47e (Handle)
-- Notes: Opens _470 (Brass Door) from behind
-- !pos 22.905 -1.087 -8.003 151
-----------------------------------
require("scripts/globals/status")
-----------------------------------

function onTrigger(player, npc)
    local brassDoor = GetNPCByID(npc:getID() - 4)

    if player:getZPos() > -11.9 and npc:getAnimation() == tpz.anim.CLOSE_DOOR and brassDoor:getAnimation() == tpz.anim.CLOSE_DOOR then
        npc:openDoor(6.5)
        -- Should be a ~1 second delay here before the door opens
        brassDoor:openDoor(4.5)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
