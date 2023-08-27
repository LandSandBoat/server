-----------------------------------
-- Dust Cloud
-- Deals Earth damage to targets in a fan-shaped area of effect. Additional effect: Blind
-- Range: 10' cone
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local duration = 120

    if mob:getMainLvl() < 10 then
        duration = duration / 2
    end

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.BLINDNESS, 30, 0, duration)

    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.EARTH, dmgmod, xi.mobskills.magicalTpBonus.MAB_BONUS, 0, 0, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.EARTH, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.EARTH)
    return dmg
end

return mobskillObject
