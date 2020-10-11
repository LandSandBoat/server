-----------------------------------
-- Area: North Gustaberg
--   NM: Bedrock Barry
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/regimes")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:addStatusEffect(tpz.effect.STONESKIN, math.random(30, 40), 0, 300)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 199)
    tpz.regime.checkRegime(player, mob, 16, 1, tpz.regime.type.FIELDS)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(math.random(3600, 4200))
end
