-----------------------------------
-- Area: Bibiki Bay
--   NM: Shankha
-- Note: Wiki says Painful Whip does increasing damage after each use, but videos do not indicate this, so I've ignored it.
--       Does not retreat into its shell, and does not poison you, unlike other uragnites.
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/status")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(tpz.mod.REGAIN, 200) -- "Seemed to have very high TP gain." (guessing 200 after watching video)
end

function onMobDeath(mob, player, isKiller)
    tpz.hunts.checkHunt(mob, player, 266)
end

function onMobDespawn(mob)
    UpdateNMSpawnPoint(mob:getID())
    mob:setRespawnTime(5400 + math.random(0, 3) * 600) -- "... every 90-120 minutes ... at exactly 100 minutes many times" (guessing 10 minute intervals)
end
