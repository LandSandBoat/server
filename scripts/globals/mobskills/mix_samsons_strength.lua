-----------------------------------
-- Mix: Samson's Strength - Gives all primary stats +10 for 60 seconds.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskillObject = {}

mobskillObject.onMobSkillCheck = function(target, mob, skill)
    return 0
end

local statii =
{
    xi.effect.STR_BOOST,
    xi.effect.DEX_BOOST,
    xi.effect.VIT_BOOST,
    xi.effect.AGI_BOOST,
    xi.effect.INT_BOOST,
    xi.effect.MND_BOOST,
    xi.effect.CHR_BOOST,
}

mobskillObject.onMobWeaponSkill = function(target, mob, skill)
    for _, effect in pairs(statii) do
        if not target:hasStatusEffect(effect) then
            target:addStatusEffect(effect, 10, 0, 60)
        end
    end

    return 0
end

return mobskillObject
