-----------------------------------
-- Area: Meriphataud Mountains (119)
--   NM: Coo Keja the Unseen
-----------------------------------
mixins = { require('scripts/mixins/job_special'), require('scripts/mixins/rotz_bodyguarded_nm') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(75600, 86400)) -- 21 to 24 hours
end

-- all body guard functionality in the rotz_bodyguarded_nm mixin

entity.onMobSpawn = function(mob)
    -- retail captures show these mods are not dependent on region control
    mob:setMod(xi.mod.UDMGPHYS, -5000)
    mob:setMod(xi.mod.UDMGRANGE, -5000)
    mob:setMod(xi.mod.UDMGBREATH, -5000)
    mob:setMod(xi.mod.UDMGMAGIC, -5000)

    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.mobSkill.MIJIN_GAKURE_1, hpp = math.randomInt(10, 15) },
        },
    })
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(75600, 86400)) -- 21 to 24 hours
end

return entity
