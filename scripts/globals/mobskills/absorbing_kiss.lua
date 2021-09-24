-----------------------------------
-- Absorbing Kiss
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
    -- str down - chr down
    local effectType = math.random(136, 142)

    skill:setMsg(MobDrainAttribute(mob, target, effectType, 10, 3, 120))

    return 1
end

return mobskill_object
