-----------------------------------
-- Area: North Gustaberg [S]
--  NPC: Lycopodium
-- !pos -275.953 12.333 262.368 88
-----------------------------------
local ID = require("scripts/zones/Garlaige_Citadel_[S]/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getMaskBit(player:getCharVar("LycopodiumTeleport_Mask"), 2) then
        player:messageSpecial(ID.text.LYCOPODIUM_ENTRANCED)
    else
        player:messageSpecial(ID.text.LYCOPODIUM_ENTRANCED)
        player:startEvent(113)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 113 then
        player:setMaskBit(player:getCharVar("LycopodiumTeleport_Mask"), "LycopodiumTeleport_Mask", 2, true)
    end
end
