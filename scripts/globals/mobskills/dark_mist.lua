-----------------------------------
--  Dark Mist
--  Family: Gargouille
--  Description: Deals dark damage to an enemy. Additional effect: Weight
--  Type: Magical (dark)
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Radial
--  Notes: Only used when flying
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getAnimationSub() ~= 5 then
        return 1
    else
        return 0
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local typeEffect = xi.effect.WEIGHT

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4.0, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 50, 0, 60)

    return dmg
end

return mobskillObject
