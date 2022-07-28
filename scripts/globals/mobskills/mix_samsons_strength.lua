-----------------------------------
-- Mix: Samson's Strength - Gives all primary stats +10 for 60 seconds.
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/mobskills")
-----------------------------------
local mobskill_object = {}

mobskill_object.onMobSkillCheck = function(target, mob, skill)
    return 0
end

mobskill_object.onMobWeaponSkill = function(target, mob, skill)
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
    for _, status in ipairs(statii) do
        if not target:hasStatusEffect(status) then
            target:addStatusEffect(status, 10, 0, 60)
        end
    end
    return 0
end

return mobskill_object
