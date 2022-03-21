-----------------------------------
--  MOB: Battledressed Chariot
-- Area: Nyzul Isle
-- Info: Enemy Leader, Uses Discoid
-----------------------------------
mixins = {require("scripts/mixins/families/chariot")}
require("scripts/globals/utils/nyzul")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller)
    if firstCall then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
    end
end

return entity
