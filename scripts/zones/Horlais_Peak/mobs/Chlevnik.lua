-----------------------------------
-- Area: Horlais Peak
-- Mob: Chlevnik
-- KSNM99 : Horns of War

-- TODO : Update Howl to give 25% Attack instead of 15% - Update Meteor to 1.6 fTP + dINT * 3(!)
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
end

entity.onMobSpawn = function(mob)
    mob:setAnimationSub(3)
    mob:setUnkillable(true)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 5)
    mob:addMod(xi.mod.STUNRES, 90)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setTP(3000) -- opens fight with a skill
    mob:setUnkillable(true)
    mob:setLocalVar('Meteor', 0)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('delay', GetSystemTime() + 30)
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() > 25 then
        mob:setMod(xi.mod.REGAIN, 80)
    else
        mob:setMod(xi.mod.REGAIN, 50)
    end

    local delay = mob:getLocalVar('delay')
    if GetSystemTime() > delay then -- Cooldown on Meteor is 30 seconds.
        mob:castSpell(xi.magic.spell.METEOR, target)
        mob:setLocalVar('delay', GetSystemTime() + 30)
    end

    if mob:getHP() == 1 and mob:getLocalVar('Meteor') == 0 then
        mob:setAutoAttackEnabled(false)
        mob:setMagicCastingEnabled(false)
        mob:setMobAbilityEnabled(false)
        mob:setLocalVar('Meteor', 1)
    end

    if mob:getLocalVar('Meteor') == 1 then
        if mob:checkDistance(target) > 40 then
            mob:resetEnmity(target)
        else
            mob:useMobAbility(xi.mobSkill.FINAL_METEOR)
        end
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN, { chance = 25, duration = math.random(5, 10) }) -- 25% chance to stun for 5-10 seconds.
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == xi.mobSkill.FINAL_METEOR then
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        mob:setAnimationSub(1)
        mob:setLocalVar('Meteor', 2)
        mob:timer(7000, function(mobArg)
            mobArg:setMagicCastingEnabled(true)
            mobArg:setAutoAttackEnabled(true)
            mobArg:setMobAbilityEnabled(true)
            mobArg:setUnkillable(false)
            mobArg:setHP(0)
        end)
    end
end

entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == xi.magic.spell.METEOR then
        spell:setAoE(xi.magic.aoe.RADIAL)
        spell:setFlag(xi.magic.spellFlag.HIT_ALL)
        spell:setRadius(30)
        spell:setAnimation(280)
        spell:setMPCost(0)
    end
end

return entity
