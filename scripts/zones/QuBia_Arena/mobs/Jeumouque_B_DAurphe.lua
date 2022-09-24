-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Jeumouque B D'Aurphe
-- BCNM: Brothers D'Aurphe
-----------------------------------
mixins = { require("scripts/mixins/job_special") }
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.LULLABYRES, 85)
    mob:setMod(xi.mod.SLEEPRES, 15)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
