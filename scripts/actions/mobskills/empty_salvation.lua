-----------------------------------
-- Empty Salvation
-- Damages all targets in range with the salvation of emptiness. Additional effect: Dispels 3 effects
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 2

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.DARK, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    -- Dispel 3 status effects
    target:dispelStatusEffect(xi.effectFlag.DISPELABLE)
    target:dispelStatusEffect(xi.effectFlag.DISPELABLE)
    target:dispelStatusEffect(xi.effectFlag.DISPELABLE)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.DARK)

    return damage
end

return mobskillObject
