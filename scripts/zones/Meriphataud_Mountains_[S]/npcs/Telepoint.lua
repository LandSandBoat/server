-----------------------------------
-- Area: Meriphataud Mountains [S]
--  NPC: Telepoint
-- !pos 305.989 -14.980 18.960 97
-----------------------------------
local ID = require("scripts/zones/Meriphataud_Mountains_[S]/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    if not player:hasKeyItem(tpz.ki.MERIPHATAUD_GATE_CRYSTAL) then
        npcUtil.giveKeyItem(player, tpz.ki.MERIPHATAUD_GATE_CRYSTAL)
    else
        player:messageSpecial(ID.text.ALREADY_OBTAINED_TELE)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
