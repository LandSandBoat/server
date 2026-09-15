-----------------------------------
-- Shadow Lord Death
-- Family: Shadow Lord
-- Description: Death animation. Deals no damage and applies no effect.
-- Notes: Used once at the end of phase 2 of the Shadow Lord mission fight.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    -- Capture: he falls 12 seconds after the animation starts.
    mob:setLocalVar('[ShadowLord]DefeatTime', GetSystemTime() + 12)

    skill:setMsg(xi.msg.basic.NONE)

    return 0
end

return mobskillObject
