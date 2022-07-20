-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Hell fly
-- KSCNM: Infernal Swarm
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.CHARMABLE, 1)
    mob:setMod(xi.mod.SLEEPRES, 250)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
