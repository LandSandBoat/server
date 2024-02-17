-----------------------------------
-- Area: Carpenters' Landing
--   NM: Cryptonberry Assassin
-- !pos 120.615 -5.457 -390.133 2
-----------------------------------
local ID = zones[xi.zone.CARPENTERS_LANDING]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180) -- 3 minutes
end

entity.onMobSpawn = function(mob)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            {
                id = xi.jsa.MIJIN_GAKURE,
                begCode = function(mobArg)
                    mobArg:messageText(mobArg, ID.text.CRYPTONBERRY_ASSASSIN_2HR)
                end,
            },
        },
    })
end

entity.onMobEngage = function(mob, target)
end

entity.onMobRoam = function(mob)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
