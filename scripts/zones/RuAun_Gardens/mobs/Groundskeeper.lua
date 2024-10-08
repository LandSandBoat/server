-----------------------------------
-- Area: RuAun Gardens
--  Mob: Groundskeeper
-- Note: Place holder Despot
-----------------------------------
local ID = zones[xi.zone.RUAUN_GARDENS]
-----------------------------------
---@type TMobEntity
local entity = {}

local despotPHTable =
{
    [ID.mob.DESPOT - 16] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 15] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 14] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 13] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 12] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 11] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 10] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 9 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 8 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 7 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 6 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 5 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 4 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 3 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 2 ] = ID.mob.DESPOT,
    [ID.mob.DESPOT - 1 ] = ID.mob.DESPOT,
}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 143, 2, xi.regime.type.FIELDS)
    xi.regime.checkRegime(player, mob, 144, 1, xi.regime.type.FIELDS)
    if optParams.isKiller then
        mob:setLocalVar('killer', player:getID())
    end
end

entity.onMobDespawn = function(mob)
    local params = {}
    params.immediate = true
    if xi.mob.phOnDespawn(mob, despotPHTable, 5, 7200, params) then -- 2 hours
        local phId = mob:getID()
        local nmId = despotPHTable[phId]
        GetMobByID(nmId):addListener('SPAWN', 'PH_VAR', function(m)
            m:setLocalVar('ph', phId)
        end)
    end
end

return entity
