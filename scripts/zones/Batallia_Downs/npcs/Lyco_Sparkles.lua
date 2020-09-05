-----------------------------------
-- Area: Batallia Downs
--  NPC:
-- !pos -366.262 -16.000 325.967 105
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getMaskBit(player:getCharVar("LycopodiumTeleport_Mask"), 1) then
        local validFlowers = {948, 949, 956, 957, 958, 959, 1120, 1410, 1411, 1413, 1725, 2554}
        for i = 1, #validFlowers do
            if npcUtil.tradeHasExactly(trade, validFlowers[i]) then
                player:startEvent(101)
                break
            end
        end
    end
end

function onTrigger(player, npc)
    if player:getMaskBit(player:getCharVar("LycopodiumTeleport_Mask"), 1) then
        player:startEvent(100)
    else
        player:messageSpecial(ID.text.SPARKLING_LIGHT)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 101 then
        player:confirmTrade()
    end
end
