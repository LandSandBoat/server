-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Beezlebub
-- KSCNM: Infernal Swarm
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.SLEEPRES, 100)
    mob:setMod(xi.mod.SILENCERES, 100)
    mob:setMod(xi.mod.PARALYZERES, 100)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
