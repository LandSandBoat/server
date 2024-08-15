-----------------------------------
-- Snow Cloud
-- Deals Ice damage to targets in a fan-shaped area of effect. Additional effect: Paralyze
-- Range: 10' cone
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = math.floor(mob:getWeaponDmg() * 2.5)

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.ICE, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, 20, 0, 120)

    return damage
end

return mobskillObject
