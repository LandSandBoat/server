-----------------------------------
-- Area: Sacrarium
--  NPC: _0st (Switch)
-- Notes: Opens _0su (Gate)
-- !pos 103.478 -1.563 50.181 28
-----------------------------------
local ID = require("scripts/zones/Sacrarium/IDs")
-----------------------------------

function onTrigger(player, npc)

    if (player:getZPos() < 50) then
        npc:openDoor()
    else
        player:messageSpecial(ID.text.CANNOT_OPEN_SIDE)
    end

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
