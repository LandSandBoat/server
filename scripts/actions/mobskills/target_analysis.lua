-----------------------------------
-- Target Analysis
-- Description: AoE Absorb All with randomness
-- Type: Magical
-----------------------------------
---@type TMobSkill
local mobskillObject = {}

local attributesDown =
{
    xi.effect.STR_DOWN,
    xi.effect.DEX_DOWN,
    xi.effect.VIT_DOWN,
    xi.effect.AGI_DOWN,
    xi.effect.MND_DOWN,
    xi.effect.INT_DOWN,
    xi.effect.CHR_DOWN,
}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(mob, target, skill, action)
    local drained = 0

    for i = 1, 7 do
        if math.randomInt(0, 100) < 40 then
            skill:setMsg(xi.mobskills.mobDrainAttribute(mob, target, attributesDown[i], 10, 3, 60))
            drained = drained + 1
        end
    end

    return drained
end

return mobskillObject
