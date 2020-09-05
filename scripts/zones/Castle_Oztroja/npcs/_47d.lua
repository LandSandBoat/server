-----------------------------------
-- Area: Castle Oztroja
--  NPC: _47d
-- !pos 20.000 24.168 -25.000 151
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/status")
-----------------------------------

function onTrigger(player, npc)
    if not player:hasKeyItem(tpz.ki.OLD_RING) then
        player:addKeyItem(tpz.ki.OLD_RING)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.OLD_RING)
    end
    if npc:getAnimation() == tpz.anim.CLOSE_DOOR then
        npc:openDoor()
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
