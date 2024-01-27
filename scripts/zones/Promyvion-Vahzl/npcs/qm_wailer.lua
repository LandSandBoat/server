-----------------------------------
-- Area: Promyvion-Vahzl
--  NPC: ???
-- Notes: Spawn Wailer Floor 4
-- !pos 339.000 -1.883 144.000 22
-----------------------------------
local ID = zones[xi.zone.PROMYVION_VAHZL]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.REMNANT_OF_A_COVETER) and
        npcUtil.popFromQM(player, npc, ID.mob.WAILER)
    then
        player:messageSpecial(ID.text.ON_NM_SPAWN)
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.POPPED_NM_OFFSET + 1)
end

return entity
