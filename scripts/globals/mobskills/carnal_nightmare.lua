-----------------------------------
-- Cernal Nightmare
--
-- Description: TP reset
-- Type: Physical (Blunt)
--
--
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
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
        skill:setMsg(xi.msg.basic.SKILL_NO_EFFECT) -- no effect
    else
        target:setTP(reset)
        skill:setMsg(xi.msg.basic.TP_REDUCED)
    end
    return reset
end

return mobskill_object
