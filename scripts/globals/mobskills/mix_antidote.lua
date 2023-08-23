-----------------------------------
-- Mix: Antidote - Removes Poison Monberaux will not remove the effects
-- of Poison Potion or other consumables like it.
-----------------------------------
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    target:delStatusEffect(xi.effect.POISON)
    return 0
end

return mobskillObject
