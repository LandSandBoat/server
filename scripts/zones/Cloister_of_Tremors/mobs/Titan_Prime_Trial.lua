-----------------------------------
-- Area: Cloister of Tremors
--  Mob: Titan Prime
-- Involved in Quest: Trial by Earth
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.REGAIN, 50)
    mob:setMod(xi.mod.EARTH_ABSORB, 100)
    mob:setMod(xi.mod.UDMGPHYS, -6000)
    mob:setMod(xi.mod.UDMGRANGE, -6000)
    mob:setMobMod(xi.mobMod.MAGIC_RANGE, 40)

    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = 857, hpp = math.random(30, 55) }, -- uses Earthen Fury once while near 50% HPP.
        },
    })
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
