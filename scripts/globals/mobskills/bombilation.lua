---------------------------------------------
-- Bombilation
--
-- Description: Resets TP of all targets in an area of effect.
-- Type: Enfeebling
-- Ignores Shadows
-- Range: Unknown radial
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
    local reset = 0
    if (target:getTP() == 0) then
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        target:setTP(reset)
        skill:setMsg(tpz.msg.basic.TP_REDUCED)
    end
    return reset
end
