-----------------------------------
-- Area: Lufaise Meadows
--  NPC: ??? - Kurrea spawn
-- !pos -249.320 -16.189 41.497 24
-----------------------------------
local ID = require("scripts/zones/Lufaise_Meadows/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    if npcUtil.tradeHas(trade, 5210) and npcUtil.popFromQM(player, npc, ID.mob.KURREA) then -- Adamantoise Soup
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end
