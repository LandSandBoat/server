-----------------------------------
-- Bombilation
--
-- Description: Resets TP of all targets in an area of effect.
-- Type: Enfeebling
-- Ignores Shadows
-- Range: Unknown radial
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    local reset = 0
    if (target:getTP() == 0) then
        skill:setMsg(tpz.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        target:setTP(reset)
        skill:setMsg(tpz.msg.basic.TP_REDUCED)
    end
    return reset
end

return mobskill_object
