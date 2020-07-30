---------------------------------------------
-- Thunderous_Yowl
-- Emits a booming cry, inflicting curse and plague
-----------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect1 = tpz.effect.PLAGUE
    local typeEffect2 = tpz.effect.CURSE_I

    MobStatusEffectMove(mob, target, typeEffect1, 5, 3, 60)
    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect2, 25, 0, 60))

    return typeEffect2
end
