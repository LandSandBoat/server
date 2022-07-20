-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Beezlebub
-- KSCNM: Infernal Swarm
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.SLEEPRES, 1000)
    mob:addMod(xi.mod.SILENCERES, 1000)
    mob:addMod(xi.mod.PARALYZERES, 1000)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
