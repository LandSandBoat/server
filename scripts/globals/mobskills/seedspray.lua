---------------------------------------------
-- Seedspray
-- Family: Rafflesia
-- Description: Single-target damage and Defense Down.
-- Type: Physical
-- Utsusemi/Blink absorb: Absorbed by 3 shadows.
-- Range: 11.5 yalms
-- Notes:
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 3
    local accmod = 1
    local dmgmod = 1
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT, 1, 1.5, 2)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING, MOBPARAM_3_SHADOW)

    MobStatusEffectMove(mob, target, tpz.effect.DEFENSE_DOWN, 8, 0, 120)

    target:takeDamage(dmg, mob, tpz.attackType.PHYSICAL, tpz.damageType.SLASHING)

    return dmg
end
