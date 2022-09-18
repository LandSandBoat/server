-----------------------------------
--  Moblin Animation
--  Used by the Moblins in Return to the Depths
--  Only used for animation purposes
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    skill:setMsg(0)
    return 0
end

return mobskill_object
