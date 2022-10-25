-----------------------------------
--  Fuscous Ooze
--  Family: Slugs
--  Description: A dusky slime inflicts encumberance and weight.
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Cone
--  Notes:
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- TODO: Encumberance seems to do nothing?
    local typeEffect = xi.effect.WEIGHT
    local duration = 45

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 50, 0, duration)

    local dmgmod = 1
    local baseDamage = mob:getWeaponDmg() * 3.7
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, baseDamage, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    return dmg
end

return mobskillObject
