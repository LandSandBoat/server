-----------------------------------
-- Area: Aydeewa Subterrane
--  NPC: ??? (Spawn Chigre(ZNM T1))
-- !pos -217 35 12 68
-----------------------------------
local ID = zones[xi.zone.AYDEEWA_SUBTERRANE]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHas(trade, xi.item.BOTTLE_OF_SPOILT_BLOOD) and
        npcUtil.popFromQM(player, npc, ID.mob.CHIGRE)
    then
        -- Trade Spoilt Blood
        player:confirmTrade()
        player:messageSpecial(ID.text.DRAWS_NEAR)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.BLOOD_STAINS)
end

return entity
