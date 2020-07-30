---------------------------------------------
-- Shell Guard
-- Increases defense of user.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local base = 100
    local typeEffect = tpz.effect.DEFENSE_BOOST
    skill:setMsg(MobBuffMove(mob, typeEffect, base, 0, 180))
    return typeEffect
end
