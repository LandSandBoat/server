---------------------------------------------
-- Earthen Ward
-- Titan grants Stoneskin to party members within area of effect.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local typeEffect = tpz.effect.STONESKIN
    local base = mob:getMainLvl()*2 + 50

    skill:setMsg(MobBuffMove(mob, typeEffect, base, 0, 180))

    return tpz.effect.STONESKIN

end
