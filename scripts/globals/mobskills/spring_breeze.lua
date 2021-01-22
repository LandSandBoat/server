-----------------------------------
-- Spring Breeze
--
-- Description: AoE TP-Reduction and Sleep tpz.effect.
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
    skill:setMsg(MobStatusEffectMove(mob, target, tpz.effect.SLEEP_I, 1, 0, 20))
    target:setTP(target:getTP() * 0.5)

    return tpz.effect.SLEEP_I
end

return mobskill_object
