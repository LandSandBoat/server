-----------------------------------
--  MOB: Long Horned Chariot
-- Area: Nyzul Isle
-- Info: Enemy Leader, Uses Brainjack
-----------------------------------
mixins = {require("scripts/mixins/families/chariot")}
require("scripts/globals/utils/nyzul")
-----------------------------------

entity.onMobDeath = function(mob, player, isKiller)
    if firstCall then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
    end
end
