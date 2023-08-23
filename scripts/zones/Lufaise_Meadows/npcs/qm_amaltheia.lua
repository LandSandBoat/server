-----------------------------------
-- Area: Lufaise Meadows
--  NPC: ??? - Amaltheia spawn
-- !pos 347.897 -10.895 264.382 24
-----------------------------------
local ID = zones[xi.zone.LUFAISE_MEADOWS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.RELIC_SHIELD) and
        npcUtil.popFromQM(player, npc, ID.mob.AMALTHEIA)
    then
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

return entity
