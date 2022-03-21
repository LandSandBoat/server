-----------------------------------
--  MOB: Nutmeg Custard
-- Area: Nyzul Isle
-- Info: Enemy Leader, Absorbs earth elemental damage
-----------------------------------
mixins = {require("scripts/mixins/families/flan")}
require("scripts/globals/status")
require("scripts/globals/utils/nyzul")
-----------------------------------

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.EARTH_ABSORB, 100)
    mob:setMod(xi.mod.REGAIN, 100)
end

entity.onMobDeath = function(mob, player, isKiller)
    if firstCall then
        xi.nyzul.spawnChest(mob, player)
        xi.nyzul.enemyLeaderKill(mob)
    end
end
