-----------------------------------
-- Thunder Thrust
-- Deals lightning elemental damage. Damage varies with TP.
-- Range: Melee------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1.7
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getWeaponDmg()*3, xi.magic.ele.THUNDER, dmgmod, xi.mobskills.magicalTpBonus.DMG_BONUS, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.THUNDER, info.hitslanded)

    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.THUNDER)
    return dmg
end

return mobskill_object
