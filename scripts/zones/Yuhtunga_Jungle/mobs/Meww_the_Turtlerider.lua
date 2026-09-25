-----------------------------------
-- Area: Yuhtunga Jungle
--  Mob: Meww the Turtlerider
-----------------------------------
mixins = { require('scripts/mixins/job_special'), require('scripts/mixins/rotz_bodyguarded_nm') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- all body guard functionality in the rotz_bodyguarded_nm mixin

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(900, 10800))
end

entity.onMobSpawn = function(mob)
    -- retail captures show these mods do have a dependency that needs to be further investigated
    mob:setMod(xi.mod.UDMGPHYS, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)

    mob:setMod(xi.mod.REGEN, 15)

    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 127, 1, xi.regime.type.FIELDS)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(75600, 86400)) -- 21 to 24 hours
end

return entity
