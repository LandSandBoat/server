-----------------------------------
-- Area: Oldton Movalpolos
--   NM: Goblin Wolfman
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)

    mob:addListener('EFFECT_LOSE', 'BLOOD_WEAPON_EFFECT_LOSE', function(mobArg, effect)
        if effect:getEffectType() == xi.effect.BLOOD_WEAPON then
            mobArg:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
            mobArg:setMod(xi.mod.DELAYP, 0)
        end
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
    mob:setMod(xi.mod.DELAYP, 0)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 75) -- Can cast Stun every minute
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    if skill:getID() == xi.mobSkill.BLOOD_WEAPON_1 then
        mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 350)
        mob:setMod(xi.mod.DELAYP, -25)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    xi.hunts.checkHunt(mob, player, 245)
end

return entity
