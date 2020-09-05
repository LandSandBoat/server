---------------------------------------------------
-- Antigravity w / 2 Gears
-- Knockback and damage, knockback varies with gear count
---------------------------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
---------------------------------------------------
-- todo The potency of the knockback effect varies with
--  the number of gears in the enemy formation. A single gear produces only a
--  slight knockback, whereas triple gears produce a very strong knockback.

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local info = MobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, TP_NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, MOBSKILL_PHYSICAL, MOBPARAM_BLUNT, MOBPARAM_WIPE_SHADOWS)
    target:delHP(dmg)
    return dmg
end
