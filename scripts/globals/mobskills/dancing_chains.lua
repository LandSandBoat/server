-----------------------------------
--  Dancing Chains
--  Description:  Applies AoE drown 15hp/sec
--  Notes: Ignores shadows, 10' AoE radius
-----------------------------------
require("scripts/globals/mobskills")
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local typeEffect = xi.effect.DROWN

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, typeEffect, 15, 0, 120))
    return typeEffect
end

return mobskill_object
