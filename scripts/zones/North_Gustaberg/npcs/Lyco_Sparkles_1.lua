-----------------------------------
-- Area: North Gustaberg
--  NPC: Lycopodium Teleport 1
-- !pos -258.186 -3.231 204.774 106
-----------------------------------
local ID = require("scripts/zones/North_Gustaberg/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if player:getMaskBit(player:getCharVar("LycopodiumTeleport_Mask"), 2) then
        local validFlowers = {948, 949, 956, 957, 958, 959, 1120, 1410, 1411, 1413, 1725, 2554}
        for i = 1, #validFlowers do
            if npcUtil.tradeHasExactly(trade, validFlowers[i]) then
                player:startEvent(265)
                break
            end
        end
    end
end
function onTrigger(player, npc)
    if player:getMaskBit(player:getCharVar("LycopodiumTeleport_Mask"), 2) then
        player:startEvent(263)
    else
        player:messageSpecial(ID.text.SPARKLING_LIGHT)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 265 then
        player:confirmTrade()
    end
end
