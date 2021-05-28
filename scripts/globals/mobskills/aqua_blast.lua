-----------------------------------
--  Aqua Blast
--
--  Description: Fires a blast of Water, dealing damage in a fan-shaped area. Additional effect: knockback
--  Type: Magical (Water)
--  Utsusemi/Blink absorb: Wipes shadows
--  Range: Fan (cone)
--  Note: There was not a lot of information about this spell available online, so
--        the initial implementation is relatively basic. It was implemented based
--        heavily off of `aqua_breath.lua`.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
  -- Do not use this weapon skill on targets behind. Sub-Zero Smash
  -- should trigger in this case.
  if target:isBehind(mob) then
    return 1
  end
  return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local dmgmod = MobBreathMove(mob, target, 0.25, 1.5, xi.magic.ele.WATER, 400)
    local dmg = MobFinalAdjustments(dmgmod, mob, skill, target, xi.attackType.BREATH, xi.damageType.WATER, MOBPARAM_WIPE_SHADOWS)
    target:takeDamage(dmg, mob, xi.attackType.BREATH, xi.damageType.WATER)
    return dmg
end

return mobskill_object
