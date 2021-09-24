-----------------------------------
-- Radiant Sacrament
-- Description: Used at regular intervals as a ranged attack when target is out of melee range.
-- Type: Physical
-- Can be dispelled: N/A
-- Utsusemi/Blink absorb: Wipes shadows
-- Range: 20' maximum distance, unknown smaller radial (around target)
-- Notes: Alexander generally uses this on targets out of his melee range. Accompanied by text
-- "Offer thy worship...
-- I shall burn away...thy transgressions..."
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 5
    local dmgmod = 2
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_DMG_VARIES, 1, 2, 3)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    MobStatusEffectMove(mob, target, xi.effect.MAGIC_DEF_DOWN, 20, 0, 60) -- Needs adjusted to retail values for power/duration

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskill_object
