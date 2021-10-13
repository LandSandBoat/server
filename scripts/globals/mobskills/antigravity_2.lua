-----------------------------------
-- Antigravity w / 2 Gears
-- Knockback and damage, knockback varies with gear count
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
-- todo The potency of the knockback effect varies with
--  the number of gears in the enemy formation. A single gear produces only a
--  slight knockback, whereas triple gears produce a very strong knockback.
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local numhits = 1
    local accmod = 1
    local dmgmod = 2
    local info = xi.mobskills.mobPhysicalMove(mob, target, skill, numhits, accmod, dmgmod, xi.mobskills.magicalTpBonus.NO_EFFECT)
    local dmg = MobFinalAdjustments(info.dmg, mob, skill, target, MOBSKILL_PHYSICAL, MOBPARAM_BLUNT, xi.mobskills.shadowBehavior.WIPE_SHADOWS)
    target:delHP(dmg)
    return dmg
end

return mobskill_object
