-----------------------------------
-- Mix: Gold Needle - Removes Petrification.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    if target:hasStatusEffect(xi.effect.PETRIFICATION) then
        target:delStatusEffect(xi.effect.PETRIFICATION)
    end
    return 0
end

return mobskill_object
