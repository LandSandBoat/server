-----------------------------------
-- Area: Batallia Downs [S]
--  NPC: Lycopodium
-- !pos -366.425 -22.127 324.666 84
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs_[S]/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getMaskBit(player:getCharVar("LycopodiumTeleport_Mask"), 1) then
        player:messageSpecial(ID.text.LYCOPODIUM_ENTRANCED)
    else
        player:messageSpecial(ID.text.LYCOPODIUM_ENTRANCED)
        player:startEvent(202)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 202 then
        player:setMaskBit(player:getCharVar("LycopodiumTeleport_Mask"), "LycopodiumTeleport_Mask", 1, true)
    end
end
