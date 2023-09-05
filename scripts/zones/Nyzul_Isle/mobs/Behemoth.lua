-----------------------------------
--  MOB: Behemoth
-- Area: Nyzul Isle
-- Info: Floor 20 and 40 Boss
-----------------------------------
mixins = { require('scripts/mixins/nyzul_boss_drops') }
require('scripts/globals/nyzul')
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- mob:addImmunity(xi.immunity.TERROR)
    -- mob:addImmunity(xi.immunity.SLEEP)
    mob:setMod(xi.mod.MAIN_DMG_RATING, 42)
    mob:addMod(xi.mod.ATT, 150)
    mob:setMobMod(xi.mobMod.NO_MP, 1)
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 15)
end

entity.onMobEngaged = function(mob, target)
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
