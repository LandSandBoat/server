-----------------------------------
-- Area: Davoi
--   NM: Dirtyhanded Gochakzuk
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.FASTCAST, 70)
    mob:setMod(xi.mod.SILENCE_MEVA, 75)
    mob:setMod(xi.mod.SLEEP_MEVA, 75)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
