-----------------------------------
-- Area: Misareaux_Coast
--  NPC: ??? (Spawn Gration)
-- !pos 113.563 -16.302 38.912 25
-----------------------------------
local ID = zones[xi.zone.MISAREAUX_COAST]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local shieldChance = 0
    if npcUtil.tradeHasExactly(trade, xi.item.HICKORY_SHIELD) then
        shieldChance = 500
    elseif npcUtil.tradeHasExactly(trade, xi.item.PICAROONS_SHIELD) then
        shieldChance = 1000
    end

    if
        shieldChance > 0 and
        npcUtil.popFromQM(player, npc, ID.mob.GRATION)
    then
        player:confirmTrade()
        GetMobByID(ID.mob.GRATION):setLocalVar('DropRate', shieldChance)
    end
end

return entity
