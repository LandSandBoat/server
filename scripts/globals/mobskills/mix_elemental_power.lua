-----------------------------------
-- Mix: Elemental Power - Applies Magic Attack Bonus to all party members for 60 seconds.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if not target:hasStatusEffect(xi.effect.MAGIC_ATK_BOOST) then
        target:addStatusEffect(xi.effect.MAGIC_ATK_BOOST, 20, 0, 60)
    end

    return 0
end

return mobskillObject
