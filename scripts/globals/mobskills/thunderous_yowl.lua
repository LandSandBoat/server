-----------------------------------
-- Thunderous_Yowl
-- Emits a booming cry, inflicting curse and plague
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
    local typeEffect1 = xi.effect.PLAGUE
    local typeEffect2 = xi.effect.CURSE_I

    MobStatusEffectMove(mob, target, typeEffect1, 5, 3, 60)
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect2, 25, 0, 60))

    return typeEffect2
end

return mobskill_object
