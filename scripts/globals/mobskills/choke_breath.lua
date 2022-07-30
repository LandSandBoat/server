---------------------------------------------
--  Choke Breath
--
--  Description: Damages enemies in a fan-shaped area of effect. Additional effect: Paralysis & Silence
--  Type: Magical
---------------------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local element = xi.magic.ele.WIND
    local typeEffectOne = xi.effect.PARALYSIS
    local typeEffectTwo = xi.effect.SILENCE
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 2, element, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.NUMSHADOWS_3)

    local resPara = xi.mobskills.applyPlayerResistance(mob, typeEffectOne, target, mob:getStat(xi.mod.MND)-target:getStat(xi.mod.MND), 0, element)
    local resSilence = xi.mobskills.applyPlayerResistance(mob, typeEffectTwo, target, mob:getStat(xi.mod.MND)-target:getStat(xi.mod.MND), 0, element)
    local durationOne = 60 * resPara
    local durationTwo = 60 * resSilence

    xi.mobskills.mobStatusEffectMove(mob, target, typeEffectOne, 1, 0, durationOne)
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffectTwo, 1, 0, durationTwo)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end

return mobskill_object
