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
    -- Observed 14 from Omega, 20 from Proto-Omega
    local power   = math.floor(mob:getMainLvl() * 0.3) - 5
    local drained = 0

    for i = 1, 7 do
        if
            math.randomInt(0, 100) < 40 and
            xi.mobskills.mobDrainAttribute(mob, target, attributesDown[i], power, 3, 60) == xi.msg.basic.ATTR_DRAINED
        then
            drained = drained + 1
        end
    end

    skill:setMsg(drained > 0 and xi.msg.basic.ATTR_DRAINED or xi.msg.basic.SKILL_MISS)

    return drained
end

return mobskillObject
