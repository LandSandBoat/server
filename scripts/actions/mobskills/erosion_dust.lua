-----------------------------------
-- Erosion Dust
-- Description: Damage and Dia
-- Yalms: 20'
-- Area: AoE
-- Type: Magical
-- Element: Light
-- Utsusemi/Blink absorb: Wipes shadows
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1.75
    local duration = math.random(15, 120)
    local damage = mob:getWeaponDmg()

    damage = xi.mobskills.mobMagicalMove(mob, target, skill, damage * dmgmod , xi.element.LIGHT, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    damage = xi.mobskills.mobFinalAdjustments(damage, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DIA, 3, 3, duration)
    target:takeDamage(damage, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return damage
end

return mobskillObject
