-----------------------------------
-- Area: Jugner Forest [S]
--  NPC: Telepoint
-- !pos -122.862 0.000 -163.154 82
-----------------------------------
local ID = require("scripts/zones/Jugner_Forest_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if not player:hasKeyItem(tpz.ki.JUGNER_GATE_CRYSTAL) then
        npcUtil.giveKeyItem(player, tpz.ki.JUGNER_GATE_CRYSTAL)
    else
        player:messageSpecial(ID.text.ALREADY_OBTAINED_TELE)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
