-----------------------------------
--  MOB: Adamantoise
-- Area: Nyzul Isle
-- Info: Floor 20 and 40 Boss, Tortoise song dispels 3 buffs
-----------------------------------
mixins = { require("scripts/mixins/nyzul_boss_drops") }
require("scripts/globals/utils/nyzul")
require("scripts/globals/status")
-----------------------------------

function onMobSpawn(mob)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.SLOW)
    mob:addImmunity(xi.immunity.ELEGY)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.SLEEP)
    mob:addImmunity(xi.immunity.POISON)
    mob:setMod(xi.mod.MAIN_DMG_RATING, 36)
    mob:addMod(xi.mod.DEF, 200)
    mob:addMod(xi.mod.ATT, 150)
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
