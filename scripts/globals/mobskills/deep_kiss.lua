-----------------------------------
-- Deep Kiss
-- Steal one effect
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

    skill:setMsg(MobDrainStatusEffectMove(mob, target))

    return 1
end

return mobskill_object
