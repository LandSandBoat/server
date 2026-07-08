-----------------------------------
-- Area: Arrapago Remnants
--  NPC: Socket
-- Trade Slavage Cells to pop Wahzil
-- Wahzil drops 2x the Cells traded
-----------------------------------
local ID = zones[xi.zone.ARRAPAGO_REMNANTS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local instance = npc:getInstance()
    if not instance then
        return
    end

    local mob           = GetMobByID(ID.mob[2][3].wahzil, instance)
    local tradeCount    = trade:getItemCount()
    local incusCell     = 5365 -- TODO: Add these to items.lua
    local spissatusCell = 5384

    for i = incusCell, spissatusCell do
        if
            mob and
            tradeCount <= 5 and
            trade:hasItemQty(i, tradeCount)
        then
            SpawnMob(ID.mob[2][3].wahzil, instance):updateClaim(player)
            player:tradeComplete()
            mob:setLocalVar('Cell', i)
            mob:setLocalVar('Qnt', tradeCount)
        end
    end
end

return entity
