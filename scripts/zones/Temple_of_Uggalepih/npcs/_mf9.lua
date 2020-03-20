-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: _mf9 (Granite Door)
-- Notes: Opens with Prelate Key
-- !pos -60 -8 -99 159
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 1137) then -- Prelate Key
        player:confirmTrade()
        player:messageSpecial(ID.text.YOUR_KEY_BREAKS, 0, 1137)
        npc:openDoor(6.5)
    end
end

function onTrigger(player, npc)
    if player:getXPos() > -62 then
        player:messageSpecial(ID.text.THE_DOOR_IS_LOCKED, 1137)
    else
        npc:openDoor(11) -- retail timed
    end

    return 1
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
