---------------------------------------------
-- Ultimate Terror
--
-- Description: AoE Absorb All with randomness
-- Type: Magical
---------------------------------------------
require("scripts/globals/mobskills")
---------------------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskillObject.onMobWeaponSkill = function(target, mob, skill)

    local drained = 0
    local threshold = 3/7

    local effects =
    {
        { xi.effect.STR_DOWN, 10, 10, 180 },
        { xi.effect.DEX_DOWN, 10, 10, 180 },
        { xi.effect.VIT_DOWN, 10, 10, 180 },
        { xi.effect.AGI_DOWN, 10, 10, 180 },
        { xi.effect.INT_DOWN, 10, 10, 180 },
        { xi.effect.MND_DOWN, 10, 10, 180 },
        { xi.effect.CHR_DOWN, 10, 10, 180 }
    }

    for _, eff in pairs(effects) do
        if math.random() < threshold then
            skill:setMsg(xi.mobskills.mobDrainAttribute(mob, target, eff[1], eff[2], eff[3], eff[4]))
            drained = drained + 1
        end
    end

    return drained

end

return mobskillObject
