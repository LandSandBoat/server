-----------------------------------
--  Nullifying Dropkick
-----------------------------------
local ID = require("scripts/zones/Empyreal_Paradox/IDs")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    if
        target:hasStatusEffect(xi.effect.PHYSICAL_SHIELD) or
        target:hasStatusEffect(xi.effect.MAGIC_SHIELD)
    then
        mob:showText(mob, ID.text.PRISHE_TEXT + 5)
        return 0
    end

    return 1
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.0
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.physicalTpBonus.DMG_VARIES, 1, 2, 3)
    local dmg = xi.mobskills.mobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    target:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
    target:delStatusEffect(xi.effect.MAGIC_SHIELD)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskillObject
