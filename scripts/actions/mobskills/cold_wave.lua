-----------------------------------
-- Cold Wave
-- Family: Bombs (Snolls)
-- Description: Inflicts Frost effect that lowers Agility and gradually reduces HP of enemies within range.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    -- TODO: Capture possible scaling
    -- Jimmayus spreadsheet states 14-15HP/tick. Might scale with level.
    -- local power  = mob:getMainLvl() / 5 * 0.6 + 6

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FROST, 14, 3, 60))

    return xi.effect.FROST
end

return mobskillObject
