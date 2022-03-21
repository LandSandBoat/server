-----------------------------------
--  MOB: Ebony Pudding
-- Area: Nyzul Isle
-- Info: Specified Mob Group
-----------------------------------
mixins = {require("scripts/mixins/families/flan")}
require("scripts/globals/utils/nyzul")
-----------------------------------

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 1)
end

entity.onMobDeath = function(mob, player, isKiller)
    if firstCall then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.specifiedGroupKill(mob)
        xi.nyzul.specifiedEnemyKill(mob)
    end
end
