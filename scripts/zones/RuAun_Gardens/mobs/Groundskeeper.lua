-----------------------------------
-- Area: RuAun Gardens
--  Mob: Groundskeeper
-- Note: Place holder Despot
-----------------------------------
local ID = zones[xi.zone.RUAUN_GARDENS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    -- Force wall groundskeepers to aggro
    -- We can't set this in the DB because they are still doll species but not "special" in any way other than this
    if mob:getPool() == xi.mobPool.GROUNDSKEEPER_WALL then
        mob:setMobMod(xi.mobMod.DETECTION, bit.bor(xi.detects.MAGIC, xi.detects.SIGHT))
    end
end

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
    if xi.mob.phOnDespawn(mob, ID.mob.DESPOT, 5, 7200, params) then -- 2 hours
        local zone = mob:getZone()
        local phId = mob:getID()

        if zone then
            zone:setLocalVar('DespotPlaceholderID', phId)
        end
    end
end

return entity
