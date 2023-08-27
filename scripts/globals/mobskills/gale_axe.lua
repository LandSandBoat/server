-----------------------------------
-- Gale Axe
-- Description: Deals wind elemental damage. Damage varies with TP.
-- Type: Magical
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1.8
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg() * 3, xi.magic.ele.WIND, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, info.hitslanded)

    if not skill:hasMissMsg() then
        target:addStatusEffect(xi.effect.CHOKE, 1, 0, 120)
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    end

    return dmg
end

return mobskillObject
