-----------------------------------
-- Sheep Bleat
-- Emits a unnerving bleat that slows down players in range.
-- Does not overwrite haste, is overwritten by haste.
-- Only used by Nightmare Sheep from Dynamis-Valkurm
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.SLOW, 5000, 0, 180))

    return xi.effect.SLOW
end

return mobskillObject
