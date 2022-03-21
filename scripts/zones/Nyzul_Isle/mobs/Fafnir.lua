-----------------------------------
--  MOB: Fafnir
-- Area: Nyzul Isle
-- Info: Floor 20 and 40 Boss, Hurricane Wing is stronger than normal
-----------------------------------
mixins = { require("scripts/mixins/nyzul_boss_drops") }
require("scripts/globals/utils/nyzul")
require("scripts/globals/status")
-----------------------------------
function onMobInitialize(mob)
    mob:setMobMod(xi.mobMod.NO_MP, 1)
end

function onMobSpawn(mob)
    mob:addImmunity(xi.immunity.SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addMod(xi.mod.ATT, 150)
    mob:addMod(xi.mod.DEF, 90)
    mob:setMod(xi.mod.MAIN_DMG_RATING, 33)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 25)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 15)
end

function onMobFight(mob,target)
end

function onMobDeath(mob, player, isKiller, firstCall)
    if firstCall then
        nyzul.enemyLeaderKill(mob)
        nyzul.vigilWeaponDrop(player, mob)
    end
end
