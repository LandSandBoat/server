-----------------------------------
--  MOB: Vanilla Custard
-- Area: Nyzul Isle
-- Info: Enemy Leader, Absorbs dark elemental damage
-----------------------------------
mixins = {require("scripts/mixins/families/flan")}
require("scripts/globals/status")
require("scripts/globals/utils/nyzul")
-----------------------------------

entity.onMobInitialize = function(mob)
    mob:setMod(xi.mod.DARK_ABSORB, 100)
end

entity.onMobDeath = function(mob, player, isKiller)
    if firstCall then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
    end
end
