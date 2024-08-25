-----------------------------------
-- Blizzard Meeble Warble
-- AOE Ice Elemental damage, inflicts a potent Paralysis effect and Frost (50 HP/tick).
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 9

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WIND, 2, xi.mobskills.magicalTpBonus.NO_EFFECT, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 50, 0, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FROST, 50, 3, 60)

    return damage
end

return mobskillObject
