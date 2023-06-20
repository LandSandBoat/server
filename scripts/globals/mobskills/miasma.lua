-----------------------------------
--  Miasma
--
--  Description: Releases a toxic cloud on nearby targets. Additional effects: Slow + Poison + Plague
--  Type: Magical
--  Utsusemi/Blink absorb: Wipes shadows?
--  Range: Less than or equal to 10.0
--  Notes: Only used by Gulool Ja Ja.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- local duration = 180
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, mob:getMainLvl() / 3, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 1250, 3, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.POISON, mob:getMainLvl() / 3, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 128, 3, 120)
    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.PLAGUE, 5, 3, 60)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 4, xi.magic.ele.EARTH, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end

return mobskillObject
