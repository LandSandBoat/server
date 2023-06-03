-----------------------------------
-- Mix: Dragon Shield - Applies Magic Defense Bonus to all party members for 60 seconds.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if not target:hasStatusEffect(xi.effect.MAGIC_DEF_BOOST) then
        target:addStatusEffect(xi.effect.MAGIC_DEF_BOOST, 10, 0, 60)
    end

    return 0
end

return mobskillObject
