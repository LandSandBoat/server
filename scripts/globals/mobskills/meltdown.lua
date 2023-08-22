-----------------------------------
-- Meltdown
-- Reactor failure causes self-destruct, dealing magic damage to targets in an area of effect.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:isMobType(xi.mobskills.mobType.NOTORIOUS) then
        return 1
    end

    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = skill:getMobHP() / 2
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.LIGHT, 1, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.LIGHT, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    mob:setHP(0)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.LIGHT)
    return dmg
end

return mobskillObject
