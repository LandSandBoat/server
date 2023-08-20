-----------------------------------
-- Holy Water - Removes Curse, Zombie, and Doom.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

local statii =
{
    xi.effect.CURSE_I,
    xi.effect.CURSE_II,
    xi.effect.ZOMBIE,
    xi.effect.DOOM,
}

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    for _, effect in pairs(statii) do
        target:delStatusEffect(effect)
    end

    return 0
end

return mobskillObject
