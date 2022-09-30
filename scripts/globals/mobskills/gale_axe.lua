-----------------------------------
-- Gale Axe
-- Description: Deals wind elemental damage. Damage varies with TP.
-- Type: Magical
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/status")
require("scripts/globals/msg")
require("scripts/globals/settings")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 1.8

    local info = xi.mobskills.mobMagicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.ACC_VARIES, 1)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.MAGICAL, xi.damageType.WIND, info.hitslanded)

    target:addStatusEffect(xi.effect.CHOKE, 1, 0, 120)
    target:takeDamage(dmg, mob, xi.attackType.MAGICAL, xi.damageType.WIND)
    return dmg
end

return mobskill_object
