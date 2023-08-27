-----------------------------------
-- Freezebite
-- Great Sword weapon skill
-- Delivers an ice elemental attack. Damage varies with TP.
-----------------------------------
local mobskillObject = {}

require("scripts/globals/weaponskills")
require("scripts/globals/mobskills")
-----------------------------------
mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMobWeaponDmg(xi.slot.MAIN), xi.magic.ele.ICE, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 1, 0, 1.5, 1.75, 2)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.ICE, xi.mobskills.shadowBehavior.NUMSHADOWS_1)

    if not skill:hasMissMsg() then
        target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.ICE)
    end

    return dmg
end

return mobskillObject
