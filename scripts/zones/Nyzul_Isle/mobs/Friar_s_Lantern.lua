-----------------------------------
--  MOB: Friar's Lantern
-- Area: Nyzul Isle
-----------------------------------
require("scripts/globals/utils/nyzul")
-----------------------------------

entity.onMobSpawn = function(mob)
    xi.nyzul.specifiedEnemySet(mob)
end

entity.onMobDeath = function(mob, player, isKiller)
    if firstCall then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.specifiedEnemyKill(mob)
    end
end
