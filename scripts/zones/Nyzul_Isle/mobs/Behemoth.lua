-----------------------------------
--  MOB: Behemoth
-- Area: Nyzul Isle
-- Info: Floor 20 and 40 Boss
--
-----------------------------------
mixins = { require("scripts/mixins/nyzul_boss_drops") }
require("scripts/globals/utils/nyzul")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.SLEEP)
    mob:setMod(xi.mod.MAIN_DMG_RATING, 42)
    mob:addMod(xi.mod.ATT, 150)
    mob:setMobMod(xi.mobMod.NO_MP, 1)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 15)
end

function onMobEngaged(mob,target)
end

function onMobFight(mob,target)
end

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.enemyLeaderKill(mob)
        nyzul.vigilWeaponDrop(player, mob)
    end
end
