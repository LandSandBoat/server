-----------------------------------
--  Glacier Splitter
--
--  Description: Cleaves into targets in a fan-shaped area. Additional effect: Paralyze
--  Type: Physical
--  Utsusemi/Blink absorb: 1-3 shadows
--  Range: Unknown cone
--  Notes: Only used the Aern wielding a sword (RDM, DRK, and PLD).
-----------------------------------
local mobskill_object = {}

require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")

-----------------------------------
mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    local numhits = math.random(1, 3)
    local accmod = 1
    local dmgmod = 1
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, xi.attackType.PHYSICAL, xi.damageType.SLASHING, info.hitslanded)

    local typeEffect = xi.effect.PARALYSIS

    MobPhysicalStatusEffectMove(mob, target, skill, typeEffect, 15, 0, 120)

    target:takeDamage(dmg, mob, xi.attackType.PHYSICAL, xi.damageType.SLASHING)
    return dmg
end

return mobskill_object
