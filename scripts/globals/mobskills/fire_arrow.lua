-----------------------------------
-- Fire Arrow
-- Deals Fire damage.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.FIRE, 1, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 3, 3.25, 3.5)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.RANGED, xi.damageType.PIERCING, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.RANGED, xi.damageType.PIERCING)
    end

    return dmg
end

return mobskillObject
