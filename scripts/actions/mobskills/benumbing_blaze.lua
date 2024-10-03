-----------------------------------
-- Benumbing Blaze
-- Description: Very High Fire Damage and Paralysis
-- Yalms: 20'
-- Area: AoE
-- Type: Magical
-- Element: Fire
-- Utsusemi/Blink absorb: Wipes shadows
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getWeaponDmg() * math.random(1, 4)
    local power = 20
    local duration = math.random (30, 90)

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.element.FIRE, 2, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.FIRE, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PARALYSIS, power, 0, duration)

    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.FIRE)

    return damage
end

return mobskillObject
