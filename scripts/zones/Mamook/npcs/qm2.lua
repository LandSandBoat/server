-----------------------------------
-- Area: Mamook
--  NPC: ??? (Spawn Iriri Samariri(ZNM T2))
-- !pos -118 7 -80 65
-----------------------------------
local ID = zones[xi.zone.MAMOOK]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.STRAND_OF_SAMARIRI_CORPSEHAIR) and
        npcUtil.popFromQM(player, npc, ID.mob.IRIRI_SAMARIRI)
    then
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NUMEROUS_STRANDS)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
