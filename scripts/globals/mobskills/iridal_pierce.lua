-----------------------------------
-- Iridal Pierce
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.H2H, info.hitslanded)

    MobPhysicalStatusEffectMove(mob, target, skill, xi.effects.AMNESIA, 1, 0, 60)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.H2H)
    return dmg
end

return mobskill_object
