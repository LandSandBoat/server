-----------------------------------
-- Howling Moon
-- Deals dark elemental damage to enemies within area of effect.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = 1
    local dStatMult = 1 -- This allows us to calculate dInt for summoners 2hr
    local info = xi.mobskills.mobMagicalMove(mob, target, skill, mob:getMainLvl() + 2, xi.magic.ele.DARK, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT, 0, 0, 9, 9, 9, dStatMult)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.DARK, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.DARK)
    return dmg
end

return mobskillObject
