-----------------------------------
-- Tenebrous Mist
--
-- Description: Resets TP of all targets in an area of effect.
-- Type: Enfeebling
-- Ignores Shadows
-- Range: Unknown radial
-----------------------------------
require("scripts/globals/monstertpmoves")
require("scripts/settings/main")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    if (mob:getFamily() == 316) then
        local mobSkin = mob:getModelId()
        if (mobSkin == 1805) then
            return 0
        else
            return 1
        end
    end
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
