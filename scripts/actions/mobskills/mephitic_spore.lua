-----------------------------------
-- Mephitic Spore
-- Family: Funguar
-- Description: Deals Dark damage to targets in a fan-shaped area of effect. Additional Effect: Poison
-- Notes: Used by Fairy Ring as its auto attack.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local params = {}

    params.baseDamage     = mob:getWeaponDmg()
    params.fTP            = { 4, 4, 4 }
    params.element        = xi.element.DARK
    params.attackType     = xi.attackType.BREATH
    params.damageType     = xi.damageType.DARK
    params.shadowBehavior = xi.mobskills.shadowBehavior.IGNORE_SHADOWS
    params.primaryMessage = xi.msg.basic.HIT_DMG

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, action, params)

    if xi.mobskills.processDamage(mob, target, skill, action, info) then
        target:takeDamage(info.damage, mob, info.attackType, info.damageType)

        xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, 50, 3, 180)
    end

    return info.damage
end

return mobskillObject
