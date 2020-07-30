-----------------------------------
-- Area: Castle Oztroja
--  NPC: _475 (Brass Door)
-- Involved in Mission: Magicite
-- !pos -99 24 -105 151
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
require("scripts/globals/status")
-----------------------------------

function onTrigger(player, npc)
    if npc:getAnimation() == tpz.anim.CLOSE_DOOR then
        player:messageSpecial(ID.text.ITS_LOCKED)
        return 1
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
