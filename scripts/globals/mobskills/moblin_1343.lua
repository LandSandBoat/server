-----------------------------------
--  Moblin Animation
--  Used by the Moblins in Return to the Depths
--  Only used for animation purposes
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(0)
    return 0
end

return mobskillObject
