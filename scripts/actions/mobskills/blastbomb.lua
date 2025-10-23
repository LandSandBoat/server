-----------------------------------
-- Blastbomb
-- Deals Fire damage in an area of effect and bind.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.element.FIRE, 3, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE, { breakBind = false })

    local duration = xi.mobskills.calculateDuration(skill:getTP(), 30, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BIND, 1, 0, duration)

    return damage
end

return mobskillObject
