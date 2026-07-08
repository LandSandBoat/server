-----------------------------------
-- Reaving Wind
-- Family: Amphiptere
-- Description: Resets TP of targets in range. Sometimes causes Amphipteres to enter into an aura state that constantly knocks back.
-- Notes: Sometimes causes Amphipteres to enter into an aura state. TODO: Need captures on conditions/chance for entering state.
-- Notes: The initial Reaving Wind that reduces TP does not seem to knock back.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local tpReduced = 0
    target:setTP(tpReduced)

    skill:setMsg(xi.msg.basic.TP_REDUCED)

    return tpReduced
end

return mobskillObject
