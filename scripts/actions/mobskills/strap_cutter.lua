-----------------------------------
-- Strap Cutter
-- Description: Removes and disables several random equipment slots for a period of time.
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
-- todo make a random for which gear to remove and how many pieces
    local remove = 0xFFFF

    target:addStatusEffectEx(xi.effect.ENCUMBRANCE_I, xi.effect.ENCUMBRANCE_I, remove, 0, 60)
end

return mobskillObject
