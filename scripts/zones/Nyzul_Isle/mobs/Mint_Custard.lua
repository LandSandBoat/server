-----------------------------------
--  MOB: Mint Custard
-- Area: Nyzul Isle
-- Info: Enemy Leader, Absorbs lightning elemental damage
-----------------------------------
mixins = {require("scripts/mixins/families/flan")}
require("scripts/globals/status")
require("scripts/globals/utils/nyzul")
-----------------------------------

function onMobInitialize(mob)
    mob:setMod(xi.mod.LTNG_ABSORB, 100)
end

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.spawnChest(mob, player)
        nyzul.enemyLeaderKill(mob)
    end
end
