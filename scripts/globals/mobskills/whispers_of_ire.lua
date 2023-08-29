-----------------------------------
-- Whispers of Ire
-- Randomly absorbs 2 to 5 attributes from target.
-- Type: Magical
-- Notes: Can also use the ability to target itself and remove all debuffs (whispers_of_ire_self.lua)
-----------------------------------
require("scripts/globals/mobskills")
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
    local amount = math.random(1,6)
    local count = 0
    local statsDrained = {}
    local size = amount

    while size > 0 do
        local effectType = math.random(1, 7)
        local check = true

        for i = 1, amount do
            if effectType == statsDrained[i] then
                check = false
            end
        end

        if check then
            xi.mobskills.mobDrainAttribute(mob, target, attributesDown[effectType], 14, 3, 60)
            count = count + 1
            statsDrained[count] = effectType
            size = size - 1
        end
    end

    if count > 0 then
        skill:setMsg(xi.msg.basic.EFFECT_DRAINED)
    else
        skill:setMsg(xi.msg.basic.SKILL_MISS)
    end

    return count
end

return mobskillObject
