-----------------------------------
-- Area: Sea Serpent Grotto
--   NM: Abyss Sahagin
-----------------------------------
mixins = {require("scripts/mixins/job_special")}
-----------------------------------

function onMobDeath(mob, player, isKiller)
end

function onMobDespawn(mob)
    mob:setRespawnTime(math.random(1200, 1500)) -- 20 to 25 minutes
end
