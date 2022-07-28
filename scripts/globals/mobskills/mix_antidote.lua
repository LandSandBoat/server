-----------------------------------
-- Mix: Antidote - Removes Poison Monberaux will not remove the effects
-- of Poison Potion or other consumables like it.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    if target:hasStatusEffect(xi.effect.POISON) then
        target:delStatusEffect(xi.effect.POISON)
    end
    return 0
end

return mobskill_object
