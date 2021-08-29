-----------------------------------------
-- ID: 5390
-- Item: bottle_of_bravers_drink
-- Item Effect: all stats +15
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local power = 15
    local duration = 180

    local effects =
    {
        xi.effect.STR_BOOST_II,
        xi.effect.DEX_BOOST_II,
        xi.effect.VIT_BOOST_II,
        xi.effect.AGI_BOOST_II,
        xi.effect.INT_BOOST_II,
        xi.effect.MND_BOOST_II,
        xi.effect.CHR_BOOST_II
    }

    for _, effect in ipairs(effects) do
        target:addStatusEffect(effect, power, 0, duration)
    end
end

return item_object
