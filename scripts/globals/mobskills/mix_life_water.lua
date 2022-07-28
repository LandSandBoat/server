-----------------------------------
-- Mix: Life Water - Applies Regen (20 HP/3 seconds) to all party members for 1 minute.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    if not target:hasStatusEffect(xi.effect.REGEN) then
        target:addStatusEffect(xi.effect.REGEN, 20, 3, 60)
    end
    return 0
end

return mobskill_object
