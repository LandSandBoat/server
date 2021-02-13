-----------------------------------
-- Demonic Howl
-- 10' AoE +50%. Slow (weaker than Haste)
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = tpz.effect.SLOW

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 1250, 0, 120))

    return typeEffect
end

return mobskill_object
