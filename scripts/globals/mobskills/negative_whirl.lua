-----------------------------------
--  Negative Whirl
--
--  Description: Slow Wipes shadows
--  Utsusemi/Blink absorb: Ignores shadows
--  Range: 10' cone
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = mob:getMainLvl() * 2
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        damage = mob:getMainLvl() * 3
    end
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.WIND, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)

    xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 8500, 0, 60)

    return dmg
end

return mobskillObject
