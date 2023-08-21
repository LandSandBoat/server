-----------------------------------
-- Area: Arrapago Remnants
--  NPC: Slot
-- trade card to pop NM
-----------------------------------
local ID = zones[xi.zone.ARRAPAGO_REMNANTS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.item.BHAFLAU_CARD) then
        local instance = npc:getInstance()
        SpawnMob(ID.mob[2][2].princess, instance):updateClaim(player)
        player:confirmTrade()
    end
end

entity.onTrigger = function(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
