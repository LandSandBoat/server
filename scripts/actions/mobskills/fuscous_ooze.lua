-----------------------------------
--  Fuscous Ooze
--  Family: Slugs
--  Description: A dusky slime inflicts encumbrance and weight.
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Cone
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local power    = math.random(1, 16)
    local duration = math.random(30, 45)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.ENCUMBRANCE_II, power, 0, duration)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.WEIGHT, 50, 0, duration)

    local dmgmod = 1
    local baseDamage = mob:getWeaponDmg() * 3.7
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, baseDamage, xi.element.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end

return mobskillObject
