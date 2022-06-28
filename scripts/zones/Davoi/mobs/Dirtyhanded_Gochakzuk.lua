-----------------------------------
-- Area: Davoi
--   NM: Dirtyhanded Gochakzuk
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.FASTCAST, 70)
    mob:setMod(xi.mod.SILENCERES, 75)
    mob:setMod(xi.mod.SLEEPRES, 75)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
