-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: ??? (Sacrificial Goblet NM)
-- !pos 300 1 255 159
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, 1184) and
        npcUtil.popFromQM(player, npc, ID.mob.SACRIFICIAL_GOBLET, { hide = 0 })
    then
        -- Uggalepih Whistle
        player:confirmTrade()
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

return entity
