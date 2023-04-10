-----------------------------------
-- Mix: Final Elixir - Restores all HP/MP to party members.
-- Used once per elixir donation. He will need a refill to use it again.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    target:addHP(target:getMaxHP())
    target:addMP(target:getMaxMP())
    return 0
end

return mobskillObject
