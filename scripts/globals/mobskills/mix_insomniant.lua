-----------------------------------
-- Mix: Insomniant - Negates Sleep.
-- Monberaux only uses this on himself when hit with an attack that causes sleep.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    if not target:hasStatusEffect(xi.effect.NEGATE_SLEEP) then
        target:addStatusEffect(xi.effect.NEGATE_SLEEP, 10, 0, 60)
    end
    return 0
end

return mobskill_object
