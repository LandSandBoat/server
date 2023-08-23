-----------------------------------
-- Area: Promyvion-Vahzl
--  NPC: ???
-- Notes: Spawn Provoker Floor 5
-- !pos -260.000 -0.003 72.000 22
-----------------------------------
local ID = zones[xi.zone.PROMYVION_VAHZL]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, xi.item.SATIATOR_REMNANT) and
        npcUtil.popFromQM(player, npc, ID.mob.PROVOKER, { message = ID.text.ON_NM_SPAWN })
    then
        player:confirmTrade()
    end
end

return entity
