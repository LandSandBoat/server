-----------------------------------
-- Flashbulb
-- Family: Atomaton
-- Description: Automaton will use Flash.
-- Type: A light-based automaton attachment.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    if mob:isTrust() then
        target:addEnmity(mob, 180, 1280)
    end

    skill:setMsg(xi.mobskills.mobStatusEffectMove(mob, target, xi.effect.FLASH, 0, 0, 15)) -- Handled in status effect

    return xi.effect.FLASH
end

return mobskillObject
