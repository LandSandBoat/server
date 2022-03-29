-----------------------------------
--  MOB: Battledressed Chariot
-- Area: Nyzul Isle
-- Info: Enemy Leader, Uses Discoid
-----------------------------------
mixins = {require("scripts/mixins/families/chariot")}
require("scripts/globals/nyzul")
-----------------------------------
local entity = {}

entity.onMobDeath = function(mob, player, isKiller, noKiller)
    if isKiller or noKiller then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
    end
end

return entity
