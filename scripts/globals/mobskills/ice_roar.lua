-----------------------------------
-- Ice Roar
-- Emits the roar of an impact event, dealing damage in a fan-shaped area of effect. Ice damage
-- Ignores Shadows
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if mob:getZoneID() == 135 or mob:getZoneID() == 111 then
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.ICE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 1.5, 2, 2.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)

    return dmg
end

return mobskillObject
