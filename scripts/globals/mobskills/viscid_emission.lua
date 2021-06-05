-----------------------------------
--  Viscid Emission
--
--  Inflicts amnesia in an area of effect.
--  Type: Magical (Enfeebling)
--  Range: Unknown cone
--  Utsusemi/Blink absorb: Ignores shadows
--
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/monstertpmoves")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(MobStatusEffectMove(mob, target, xi.effect.AMNESIA, 1, 0, 60))
    return nil
end

return mobskill_object
