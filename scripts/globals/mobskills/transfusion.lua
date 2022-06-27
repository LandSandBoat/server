-----------------------------------
--  Transfusion
--
--  Description: Steals HP from players within range.
--  Type: Magical
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: Unknown radial
--  Notes:
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    local dmgmod = 1

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    skill:setMsg(xi.mobskills.mobDrainMove(mob, target, xi.mobskills.drainType.HP, dmg, xi.attackType.MAGICAL, xi.damageType.DARK))

    return dmg
end

return mobskill_object
