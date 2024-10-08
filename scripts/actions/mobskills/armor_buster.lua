-----------------------------------
-- Armor_Buster
-- Description:
-- Type: Magical
-- additional effect: WEIGHT
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getLocalVar('citadelBuster') == 0 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 3

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WATER, 2.5, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    xi.mobskills.mobPhysicalStatusEffectMove(mob, target, skill, xi.effect.WEIGHT, 20, 3, 45)

    return damage
end

return mobskillObject
