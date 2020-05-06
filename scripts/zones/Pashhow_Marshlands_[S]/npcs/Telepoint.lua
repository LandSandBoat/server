-----------------------------------
-- Area: Pashhow Marshlands [S]
--  NPC: Telepoint
-- !pos 345.472 24.279 -114.731 90
-----------------------------------
local ID = require("scripts/zones/Pashhow_Marshlands_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if not player:hasKeyItem(tpz.ki.PASHHOW_GATE_CRYSTAL) then
        npcUtil.giveKeyItem(player, tpz.ki.PASHHOW_GATE_CRYSTAL)
    else
        player:messageSpecial(ID.text.ALREADY_OBTAINED_TELE)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
