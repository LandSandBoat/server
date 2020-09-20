---------------------------------------------
-- Subsonics
-- Lower defense
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    if (mob:isMobType(MOBTYPE_NOTORIOUS)) then
        return 0
    end
    return 1
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.DEFENSE_DOWN

    skill:setMsg(MobStatusEffectMove(mob, target, typeEffect, 25, 0, 180))


        return typeEffect
end
