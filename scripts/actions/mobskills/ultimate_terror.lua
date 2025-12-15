-----------------------------------
-- Ultimate Terror
--
-- Description: AoE Absorb All
-- Type: Magical
-----------------------------------
require('scripts/globals/mobskills')
-----------------------------------
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

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local numToDrain = math.random(2, 4)
    local shuffled = utils.shuffle(attributesDown)
    local drained = 0

    for i = 1, numToDrain do
        local effect = xi.mobskills.mobDrainAttribute(mob, target, shuffled[i], 15, 0, 60)
        if effect > 0 then
            drained = drained + 1
        end
    end

    if drained > 0 then
        skill:setMsg(xi.msg.basic.EFFECT_DRAINED)
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return drained
end

return mobskillObject
