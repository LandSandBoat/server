-----------------------------------
-- Mix: Life Water - Applies Regen (20 HP/3 seconds) to all party members for 1 minute.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    if not target:hasStatusEffect(xi.effect.REGEN) then
        target:addStatusEffect(xi.effect.REGEN, 20, 3, 60)
    end

    return 0
end

return mobskillObject
