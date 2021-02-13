-----------------------------------
-- Molluscous Mutation
--
-- Family: Xzomit
-- Type: Enhancing
-- Can be dispelled: Yes
-- Utsusemi/Blink absorb: N/A
-- Range: Self
-- Notes: ~75% Defense boost.
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
    local typeEffect = tpz.effect.DEFENSE_BOOST
    skill:setMsg(MobBuffMove(mob, typeEffect, 75, 0, 60))

    return typeEffect
end

return mobskill_object
