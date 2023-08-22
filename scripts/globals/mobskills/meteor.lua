-----------------------------------
--  Meteor
--
--  Description: Hardcore non-elemental damage
--  Type: Magical
--
--
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local damage = 14 + mob:getMainLvl() * 30
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, damage, xi.magic.ele.NONE, 1, xi.mobskills.magicalTpBonus.PDIF_BONUS, 0, 0, 1, 1, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.NONE, xi.mobskills.shadowBehavior.IGNORE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.NONE)
    return dmg
end

return mobskillObject
