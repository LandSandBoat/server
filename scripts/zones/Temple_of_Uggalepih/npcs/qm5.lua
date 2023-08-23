-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: ??? (Crimson-toothed Pawberry NM)
-- !pos -39 -24 27 159
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.OFFERING_TO_UGGALEPIH) and
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
