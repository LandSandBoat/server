-----------------------------------
-- Auroral Wind
-- Family: Aern
-- Description: Deals Light damage to targets in front of mob. Additional Effect: Silence
-- Notes: Base damage seems to be (Level * 2) or (Level * 3) at random.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getMainLvl() * math.random(2, 3)
    params.fTP            = { 1.0, 1.0, 1.0 }
    params.element        = xi.element.LIGHT
    params.attackType     = xi.attackType.MAGICAL
    params.damageType     = xi.damageType.LIGHT
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 120)
    end

    return info.damage
end

return mobskillObject
