-----------------------------------
-- Barrage
-- Fires multiple shots at once.
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
    mob:addStatusEffect(xi.effect.BARRAGE, 0, 0, 60)
    return 0
end

return mobskill_object
