-----------------------------------
--  Thunderbolt
--  Description: Deals Lightning damage in an area of effect. Additional effect: Stun
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = math.random(8, 14)
    local damage = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.element.THUNDER, 0.6, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.THUNDER)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.STUN, 1, 0, duration)

    return damage
end

return mobskillObject
