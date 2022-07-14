-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Vaicoliaux B D'Aurphe
-- BCNM: Brothers D'Aurphe
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.LULLABYRES, 750)
    mob:addMod(xi.mod.SLEEPRES, 150)
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
