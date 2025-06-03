-----------------------------------
-- Area: Arrapago Remnants
--  NPC: Slot
-- trade card to pop NM
-----------------------------------
local ID = zones[xi.zone.ARRAPAGO_REMNANTS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if npcUtil.tradeHas(trade, xi.item.BHAFLAU_CARD) then
        local instance = npc:getInstance()

        if instance then
            SpawnMob(ID.mob[2][2].princess, instance):updateClaim(player)
            player:confirmTrade()
        end
    end
end

return entity
