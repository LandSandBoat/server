-----------------------------------
-- Mix: Elemental Power - Applies Magic Attack Bonus to all party members for 60 seconds.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
    if not target:hasStatusEffect(xi.effect.MAGIC_ATK_BOOST) then
        target:addStatusEffect(xi.effect.MAGIC_ATK_BOOST, 20, 0, 60)
    end
    return 0
end

return mobskill_object
