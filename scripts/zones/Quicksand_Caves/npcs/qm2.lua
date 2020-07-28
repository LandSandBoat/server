-----------------------------------
-- Area: Quicksand Caves
--  NPC: qm2
-- Note: Spawns Tribunus VII-I
-- !pos -49.944 -0.891 -139.485 208
-----------------------------------
local ID = require("scripts/zones/Quicksand_Caves/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 1190) and npcUtil.popFromQM(player, npc, ID.mob.TRIBUNUS_VII_I) then -- Antican Tag
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
