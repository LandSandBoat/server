-----------------------------------
-- Ice Guillotine
-- Family: Ruszors
-- Description: Bites at all targets in front. Additional Effect: Max HP Down
-- Notes:
-- * Scylla exclusive, this skill is not used on its own and is scripted to fire after Frozen Mist is used.
-- * Skill can not be interrupted by being out of range. The skill will always go off and hit anyone inside the cone.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() + 2
    params.fTP            = { 3.00, 3.00, 3.00 } -- TODO: Capture fTPs
    params.element        = xi.element.ICE
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.ICE
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

         -- TODO: Capture durations of effects
         -- TODO: Capture power of Amnesia.
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.MAX_HP_DOWN, 50, 0, 180)
        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.AMNESIA, 1, 0, 60)
        -- TODO: Scylla gains a Paralysis aura after using this skill. Maybe handle in mob script.
    end

    return info.damage
end

return mobskillObject
