-----------------------------------
--  Earth Pounder
--
--  Description: Deals Earth damage to enemies within area of effect. Additional effect: Dexterity Down
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: 15' radial
--  Notes:
-----------------------------------
require("scripts/globals/mobskills")

-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.DEX_DOWN, 10, 10, 180)

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.EARTH, 1, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 2, 3, 4)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end

return mobskillObject
