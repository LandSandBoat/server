---------------------------------------------
--  Choke Breath
--
--  Description: Damages enemies in a fan-shaped area of effect. Additional effect: Paralysis & Silence
--  Type: Physical
-- 100 physical damage slashing * pdif
---------------------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1
    local element = xi.magic.ele.WIND
    local typeEffectOne = xi.effect.PARALYSIS
    local typeEffectTwo = xi.effect.SILENCE
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_FLAT, 1, 1, 1)

    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    local resPara = xi.mobskills.applyPlayerResistance(mob, typeEffectOne, target, mob:getStat(xi.mod.MND)-target:getStat(xi.mod.MND), 0, element)
    local resSilence = xi.mobskills.applyPlayerResistance(mob, typeEffectTwo, target, mob:getStat(xi.mod.MND)-target:getStat(xi.mod.MND), 0, element)
    local durationOne = 60 * resPara
    local durationTwo = 60 * resSilence

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffectOne, 1, 0, durationOne)
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffectTwo, 1, 0, durationTwo)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskillObject
