-----------------------------------
-- Area: Castle Oztroja
--  NPC: _m70 (Torch Stand)
-- Involved in Mission: Magicite
-- !pos -97.134 24.250 -105.979 151
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
require("scripts/globals/keyitems")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:hasKeyItem(tpz.ki.YAGUDO_TORCH) then
        player:startEvent(11)
    else
        player:messageSpecial(ID.text.PROBABLY_WORKS_WITH_SOMETHING_ELSE)
    end

    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
