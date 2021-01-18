---------------------------------------------------
-- BrainJack
--
---------------------------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2.3
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT, info.hitslanded)

    MobPhysicalStatusEffectMove(mob, target, skill, tpz.effect.CHARM_I, 0, 0, 60)
    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.BLUNT)

    return dmg
end

return mobskill_object
