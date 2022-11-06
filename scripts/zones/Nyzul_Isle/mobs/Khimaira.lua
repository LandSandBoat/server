-----------------------------------
--  MOB: Khimaira
-- Area: Nyzul Isle
-- Info : Floor 60 80 100 Boss
-----------------------------------
mixins = { require('scripts/mixins/nyzul_boss_drops') }
require('scripts/globals/nyzul')
require('scripts/globals/status')
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- mob:addImmunity(xi.immunity.SLEEP)
    -- mob:addImmunity(xi.immunity.TERROR)
    mob:setMod(xi.mod.MEVA, 25)
    mob:setMod(xi.mod.MAIN_DMG_RATING, 33)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 15)
    mob:addMod(xi.mod.ATT, 100)
    -- TODO: mob:addResist({ xi.resist.ENFEEBLING_STUN, 10, 0 })
    mob:setMobMod(xi.mobMod.ROAM_DISTANCE, 15)
end

entity.onMobFight = function(mob, target)
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        xi.nyzul.enemyLeaderKill(mob)
        xi.nyzul.vigilWeaponDrop(player, mob)
        xi.nyzul.handleRunicKey(mob)
    end
end

return entity
