-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: ??? (Crimson-toothed Pawberry NM)
-- !pos -39 -24 27 159
-----------------------------------
local ID = require("scripts/zones/Temple_of_Uggalepih/IDs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, 1183) and
        npcUtil.popFromQM(player, npc, { ID.mob.CRIMSON_TOOTHED_PAWBERRY, ID.mob.CRIMSON_TOOTHED_PAWBERRY + 2 }, { hide = 900 })
    then
        player:confirmTrade()
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NM_OFFSET + 1)
end

return entity
