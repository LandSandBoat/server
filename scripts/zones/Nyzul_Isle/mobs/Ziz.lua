-----------------------------------
--  MOB: Ziz
-- Area: Nyzul Isle
-----------------------------------
require("scripts/globals/utils/nyzul")
-----------------------------------

entity.onMobSpawn = function(mob)
    xi.nyzul.specifiedEnemySet(mob)
    mob:AnimationSub(13)
end

entity.onMobDeath = function(mob, player, isKiller)
    if firstCall then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.specifiedEnemyKill(mob)
    end
end
