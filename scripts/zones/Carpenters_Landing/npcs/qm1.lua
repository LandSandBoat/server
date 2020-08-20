-----------------------------------
-- Area: Carpenters' Landing (2)
--  NPC: ??? (qm1)
-- Note: Used to spawn Mycophile NM
-- !pos 145.500 -9.000 -699.000 2
-----------------------------------
local ID = require("scripts/zones/Carpenters_Landing/IDs")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
    -- Sleepshroom, Woozyshroom, Danceshroom
    if npcUtil.tradeHas(trade, {4373, 4374, 4375}) and npcUtil.popFromQM(player, npc, ID.mob.MYCOPHILE) then
        player:confirmTrade()
    end
end

function onTrigger(player, npc)
    player:messageSpecial(ID.text.MYCOPHILE_MUSHROOM)
end
