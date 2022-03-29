-----------------------------------
--  MOB: Racing Chariot
-- Area: Nyzul Isle
-- Info: Specified Mob Group
-----------------------------------
mixins = {require("scripts/mixins/families/chariot")}
require("scripts/globals/nyzul")
-----------------------------------

entity.onMobDeath = function(mob, player, isKiller)
    if firstCall then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.specifiedGroupKill(mob)
    end
end
