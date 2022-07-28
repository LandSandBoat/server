-----------------------------------
-- Mix: Guard Drink - Applies Protect (+220 Defense) and Shell to all party members for 5 minutes.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)

    return 0
end

return mobskill_object
