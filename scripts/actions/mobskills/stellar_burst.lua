-----------------------------------
-- Stellar Burst
-- A starburst damages targets in an area of effect. Additional effect: Silence
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg()

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.NONE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.NONE)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SILENCE, 1, 0, 30)

    if not target:isTrust() then
        mob:resetEnmity(target)
    end

    return damage
end

return mobskillObject
