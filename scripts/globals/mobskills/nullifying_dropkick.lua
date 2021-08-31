-----------------------------------
--  Nullifying Dropkick
--
-----------------------------------
local ID = require("scripts/zones/Empyreal_Paradox/IDs")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if (target:hasStatusEffect(xi.effect.PHYSICAL_SHIELD) or target:hasStatusEffect(xi.effect.MAGIC_SHIELD)) then
        mob:showText(mob, ID.text.PRISHE_TEXT + 5)
        return 0
    end
    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    local numhits = 1
    local accmod = 1
    local dmgmod = 2.0
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.BLUNT, info.hitslanded)

    target:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
    target:delStatusEffect(xi.effect.MAGIC_SHIELD)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.BLUNT)
    return dmg
end

return mobskill_object
