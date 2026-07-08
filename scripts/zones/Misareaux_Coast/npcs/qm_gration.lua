-----------------------------------
-- Area: Misareaux_Coast
--  NPC: ??? (Spawn Gration)
-- !pos 113.563 -16.302 38.912 25
-- !additem PICAROONS_SHIELD
-- !additem HICKORY_SHIELD
-----------------------------------
local ID = zones[xi.zone.MISAREAUX_COAST]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    if
        npcUtil.tradeHasExactly(trade, xi.item.PICAROONS_SHIELD) and
        npcUtil.popFromQM(player, npc, ID.mob.GRATION)
    then
        player:confirmTrade()
        player:messageSpecial(ID.text.SNATCHED_AWAY, xi.item.PICAROONS_SHIELD)
        GetMobByID(ID.mob.GRATION):setLocalVar('shieldType', xi.item.PICAROONS_SHIELD)
    end

    if
        npcUtil.tradeHasExactly(trade, xi.item.HICKORY_SHIELD) and
        npcUtil.popFromQM(player, npc, ID.mob.GRATION)
    then
        player:confirmTrade()
        player:messageSpecial(ID.text.SNATCHED_AWAY, xi.item.HICKORY_SHIELD)
        GetMobByID(ID.mob.GRATION):setLocalVar('shieldType', xi.item.HICKORY_SHIELD)
    end
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.A_SHATTERED_SHIELD)
end

return entity
