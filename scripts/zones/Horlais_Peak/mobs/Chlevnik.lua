-----------------------------------
-- Area: Horlais Peak
-- Mob: Chlevnik
-- KSNM99 : Horns of War

-- TODO : Update Meteor to 1.6 fTP + dINT * 3(!)
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMobMod(xi.mobMod.AOE_HIT_ALL, 1)
    mob:setBehavior(bit.bor(mob:getBehavior(), xi.behavior.NO_TURN))
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.STUN_RES_RANK, 10)

    mob:setMod(xi.mod.TRIPLE_ATTACK, 5)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.REGAIN, 50)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)

    mob:setTP(3000)
    mob:setUnkillable(true)
    mob:setAutoAttackEnabled(true)
    mob:setMagicCastingEnabled(true)
    mob:setMobAbilityEnabled(true)
    mob:setAnimationSub(0)

    mob:setLocalVar('queueFinalMeteor', 0)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('meteorDelay', GetSystemTime() + 30)
end

entity.onMobFight = function(mob, target)
    if
        mob:getHP() == 1 and
        mob:getLocalVar('queueFinalMeteor') == 0
    then
        mob:setLocalVar('queueFinalMeteor', 1)
        mob:setAutoAttackEnabled(false)
        mob:setMagicCastingEnabled(false)
        mob:setMobAbilityEnabled(false)
        mob:setMobMod(xi.mobMod.NO_MOVE, 1)
        return
    end

    if
        mob:getLocalVar('queueFinalMeteor') == 1 and
        not xi.combat.behavior.isEntityBusy(mob)
    then
        mob:useMobAbility(xi.mobSkill.FINAL_METEOR, nil, nil, true) -- Ignoring distance based off retail capture.
        mob:setLocalVar('queueFinalMeteor', 2)
    end

    local delay = mob:getLocalVar('meteorDelay')

    if GetSystemTime() > delay then -- Cooldown on Meteor is 30 seconds.
        mob:castSpell(xi.magic.spell.METEOR, target)
        mob:setLocalVar('meteorDelay', GetSystemTime() + 30)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.WILD_HORN,
        xi.mobSkill.THUNDERBOLT_BEHEMOTH,
        xi.mobSkill.KICK_OUT,
        xi.mobSkill.SHOCK_WAVE_BEHEMOTH,
        xi.mobSkill.FLAME_ARMOR,
        xi.mobSkill.HOWL_BEHEMOTH,
    }

    return skillList[math.randomInt(1, #skillList)]
end

entity.onAdditionalEffect = function(mob, target, damage)
    local pTable =
    {
        chance   = 25,
        effectId = xi.effect.STUN,
        duration = 10,
    }

    return xi.combat.action.executeAddEffectEnfeeblement(mob, target, pTable)
end

entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == xi.magic.spell.METEOR then
        spell:setAoE(xi.magic.aoe.RADIAL)
        spell:setRadius(30)
        spell:setAnimation(280)
        spell:setMPCost(0)
    end
end

return entity
