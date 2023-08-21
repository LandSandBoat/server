-----------------------------------
-- Area: Caedarva Mire
--  NPC: ??? (Spawn Tyger(ZNM T4))
-- !pos -766 -12 632 79
-----------------------------------
local ID = zones[xi.zone.CAEDARVA_MIRE]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.CHUNK_OF_SINGED_BUFFALO) and
        npcUtil.popFromQM(player, npc, ID.mob.TYGER)
    then
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.STIFLING_STENCH)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
