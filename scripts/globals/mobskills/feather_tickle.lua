---------------------------------------------
-- Feather Tickle
--
-- Description: Reduces tp to zero.
---------------------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
---------------------------------------------

function onMobSkillCheck(target, mob, skill)
    return 0
end

function onMobWeaponSkill(target, mob, skill)
    local tpReduced = 0
    target:setTP(tpReduced)

    skill:setMsg(tpz.msg.basic.TP_REDUCED)

    return tpReduced
end
