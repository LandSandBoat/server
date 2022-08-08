-----------------------------------
-- Area: Throne Room
--  Mob: Duke Dantalian
-- BCNM: Kindred Spirits
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addMod(xi.mod.SLEEPRES, 75)
    mob:addMod(xi.mod.LULLABYRES, 75)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
