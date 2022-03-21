-----------------------------------
--  MOB: Ziz
-- Area: Nyzul Isle
-----------------------------------
require("scripts/globals/utils/nyzul")
-----------------------------------

function onMobSpawn(mob)
    nyzul.specifiedEnemySet(mob)
    mob:AnimationSub(13)
end

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.spawnChest(mob, player)
        nyzul.specifiedEnemyKill(mob)
    end
end
