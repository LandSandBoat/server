-----------------------------------
--  Stun_Cannon
--
--  Description: 20'(?) cone ~300 magic damage and Paralysis, ignores Utsusemi
--  Type: Magical
--
--  Range: 20 yalms
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    local currentForm = mob:getLocalVar("form")

    if (mob:getAnimationSub() == 2 and currentForm == 1) then -- proto-omega bipedform
        return 0
    end
    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
   local dmgmod = 1.5
   local typeEffect = xi.effect.PARALYSIS

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 20, 0, 120)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, xi.magic.ele.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end

return mobskill_object
