-----------------------------------
-- Area: Yhoator Jungle
--   NM: Bright-handed Kunberry
-----------------------------------
mixins =
{
    require('scripts/mixins/families/tonberry'),
    require('scripts/mixins/job_special'),
    require('scripts/mixins/rotz_bodyguarded_nm')
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobDeath = function(mob, player, optParams)
    xi.regime.checkRegime(player, mob, 133, 1, xi.regime.type.FIELDS)
end

-- all body guard functionality in the rotz_bodyguarded_nm mixin

entity.onMobSpawn = function(mob)
    -- retail captures show these mods are not dependent on region control
    mob:setMod(xi.mod.UDMGPHYS, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)
end

entity.onMobDespawn = function(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(75600, 77400)) -- 21 to 21.5 hours
end

return entity
