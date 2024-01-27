-----------------------------------
-- Target Analysis
-- Description: AoE Absorb All with randomness
-- Type: Magical
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
    local skillList = mob:getMobMod(xi.mobMod.SKILL_LIST)
    local mobhp = mob:getHPP()

    if
        (skillList == 54 and mobhp < 26) or
        (skillList == 727 and mob:getAnimationSub() == 1)
    then
        return 0
    else
        return 1
    end
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    local drained = 0

    for i = 1, 7 do
        if math.random(0, 100) < 40 then
            skill:setMsg(xi.mobskills.mobDrainAttribute(mob, target, attributesDown[i], 10, 3, 60))
            drained = drained + 1
        end
    end

    return drained
end

return mobskillObject
