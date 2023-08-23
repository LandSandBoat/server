-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: ??? (Beryl-footed Molberry NM)
-- !pos -57 0 4 159
-----------------------------------
local ID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.TONBERRY_RATTLE) and
        npcUtil.popFromQM(player, npc, ID.mob.BERYL_FOOTED_MOLBERRY, { hide = 900 })
    then
        player:confirmTrade()
    else
        player:messageSpecial(ID.text.NOTHING_HAPPENS)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NM_OFFSET)
end

return entity
