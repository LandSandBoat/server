-----------------------------------
-- Slaverous Gale
--
-- Description: Deals earth damage that inflicts Plague and Slow effects on targets in front of the caster
-- Type: Magical (Earth)
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local typeEffectOne = xi.effect.PLAGUE
    local typeEffectTwo = xi.effect.SLOW
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffectOne, 1, 3, 60)
    xi.mobskills.mobStatusEffectMove(mob, target, typeEffectTwo, 1250, 0, 60)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * math.random(4, 6), xi.magic.ele.EARTH, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.WIPE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end

return mobskillObject
