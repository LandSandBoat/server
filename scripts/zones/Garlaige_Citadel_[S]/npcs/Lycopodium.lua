-----------------------------------
-- Area: Garlaige Citadel [S]
--  NPC: Lycopodium
-- !pos -96.753 -1.000 -167.332 164
-----------------------------------
local ID = require("scripts/zones/Garlaige_Citadel_[S]/IDs")
require("scripts/globals/npc_util")
require("scripts/globals/utils")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if player:getMaskBit(player:getCharVar("LycopodiumTeleport_Mask"), 0) then
        player:messageSpecial(ID.text.LYCOPODIUM_ENTRANCED)
    else
        player:messageSpecial(ID.text.LYCOPODIUM_ENTRANCED)
        player:startEvent(30)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 30 then
        player:setCharVar("LycopodiumTeleport_Mask", utils.mask.setBit(player:getCharVar("LycopodiumTeleport_Mask"), 0, true))
    end
end
