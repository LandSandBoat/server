-----------------------------------
-- Lodesong
--
-- Description: Weighs down targets in an area of effect.
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    -- can only used if not silenced
    if (mob:getMainJob() == xi.job.BRD and mob:hasStatusEffect(xi.effect.SILENCE) == false) then
        return 0
    end
    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(MobStatusEffectMove(mob, target, xi.effect.WEIGHT, 50, 0, 50))

    return nil
end

return mobskill_object
