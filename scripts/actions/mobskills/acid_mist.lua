-----------------------------------
-- Acid Mist
-- Deals Water damage to enemies within an area of effect. Additional effect: Attack Down
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power    = 50
    local duration = 120

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ATTACK_DOWN, power, 0, duration)

    local dmgmod = 1
    local info   = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3.2, xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg    = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)

    return dmg
end

return mobskillObject
