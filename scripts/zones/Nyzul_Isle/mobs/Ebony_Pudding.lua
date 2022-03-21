-----------------------------------
--  MOB: Ebony Pudding
-- Area: Nyzul Isle
-- Info: Specified Mob Group
-----------------------------------
mixins = {require("scripts/mixins/families/flan")}
require("scripts/globals/utils/nyzul")
-----------------------------------

function onMobSpawn(mob)
    mob:setMobMod(xi.mobMod.CHECK_AS_NM, 1)
end

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.spawnChest(mob, player)
        nyzul.specifiedGroupKill(mob)
        nyzul.specifiedEnemyKill(mob)
    end
end
