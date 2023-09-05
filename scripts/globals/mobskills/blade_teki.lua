-----------------------------------
-- Blade: Teki
-- Description: Deals water elemental damage.
-- Type: Magical
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN) * 3, xi.magic.ele.WATER, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 1, 0, 1, 1.5, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WATER, info.hitslanded)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WATER)
    end

    return dmg
end

return mobskillObject
