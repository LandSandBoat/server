-----------------------------------
--  MOB: Wamoura
-- Area: Nyzul Isle
-----------------------------------
require("scripts/globals/utils/nyzul")
-----------------------------------

function onMobSpawn(mob)
    nyzul.specifiedEnemySet(mob)
end

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.spawnChest(mob, player)
        nyzul.specifiedEnemyKill(mob)
    end
end
