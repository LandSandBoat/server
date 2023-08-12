-----------------------------------
-- Mix: Samson's Strength - Gives all primary stats +10 for 60 seconds.
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
    if target:getID() == mob:getID() then
        skill:setMsg(762) -- Monberaux uses Mix: {ID} -- All of Monberaux's status parameters are boosted.
    else
        skill:setMsg(365) -- All of targets's status parameters are boosted.
    end

    for _, effect in pairs(statii) do
        if not target:hasStatusEffect(effect) then
            target:addStatusEffect(effect, 10, 0, 60)
        end
    end

    -- What happens if no effect?
    return xi.effect.VIT_BOOST_II -- VIT_BOOST_II = 121
end

return mobskillObject
