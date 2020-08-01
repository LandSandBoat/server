-----------------------------------
-- Area: Castle Oztroja
--  NPC: _473 (Brass Door)
-- Notes: Opened by Torch Stands near Password #3
-- !pos -43.455 -20.161 20.014 151
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
require("scripts/globals/status")
-----------------------------------

function onTrigger(player, npc)
    if npc:getAnimation() == tpz.anim.CLOSE_DOOR then
        player:messageSpecial(ID.text.ITS_LOCKED)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
