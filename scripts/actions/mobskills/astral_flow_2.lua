-----------------------------------
-- Astral Flow
-- This Astral Flow is used for summoners that must have their pet alive to use it.
-- Ex. Dynamis Summoners, Maat, etc.
-- Intended to be used with xi.pets.summon.setupSummon.
-- If you are using this type of Astral Flow, do NOT use the mixin. Script it manually.
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    skill:setMsg(xi.msg.basic.USES)

    local pet = mob:getPet()

    if not pet then
        return
    end

    pet:setLocalVar('astralFlowUsed', 1)
end

return mobskillObject
