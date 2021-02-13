-----------------------------------
-- Ion_Efflux
--
-- Description: 10'(?) cone  Paralysis, ignores Utsusemi
-- Type: Magical
--
-- Range: 10 yalms
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if (mob:getAnimationSub() <= 1) then
        return 0
    end
    return 1
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = tpz.effect.PARALYSIS

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 20, 0, 60))

    return typeEffect
end

return mobskill_object
