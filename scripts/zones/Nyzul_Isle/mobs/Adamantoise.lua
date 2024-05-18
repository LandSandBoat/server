-----------------------------------
--  MOB: Adamantoise
-- Area: Nyzul Isle
-- Info: Floor 20 and 40 Boss, Tortoise song dispels 3 buffs
-----------------------------------
mixins = { require('scripts/mixins/nyzul_boss_drops') }
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    -- Set Immunities.
    -- mob:addImmunity(xi.immunity.STUN)
    -- mob:addImmunity(xi.immunity.SLOW)
    -- mob:addImmunity(xi.immunity.POISON)
    -- mob:addImmunity(xi.immunity.ELEGY)
    -- mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    -- mob:addImmunity(xi.immunity.DARK_SLEEP)
    -- mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.MAIN_DMG_RATING, 36)
    mob:addMod(xi.mod.DEF, 200)
    mob:addMod(xi.mod.ATT, 150)

    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 15)
end

entity.onMobEngage = function(mob, target)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.enemyLeaderKill(mob)
        xi.nyzul.vigilWeaponDrop(player, mob)
    end
end

return entity
