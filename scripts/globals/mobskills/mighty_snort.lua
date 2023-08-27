---------------------------------------------
--  Mighty Snort
--
--  Deals Wind damage to targets in a fan-shaped area of effect. Additional effect: Hate reset
--  Type: Magical (Wind)
--  Only used by certain Buffalo NMs
--
---------------------------------------------
require("scripts/globals/mobskills")
---------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.WIND, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 4.5, 4.75, 5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    mob:resetEnmity(target)

    return dmg
end

return mobskillObject
