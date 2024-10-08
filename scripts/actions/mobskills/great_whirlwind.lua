-----------------------------------
--  Great Whirlwind
--  Description: Deals Wind damage to targets in front. Additional effect: Choke
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown cone
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * 4
    local power  = math.floor(mob:getMainLvl() * 0.15) + 4

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.WIND, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.CHOKE, power, 3, 60)

    return damage
end

return mobskillObject
