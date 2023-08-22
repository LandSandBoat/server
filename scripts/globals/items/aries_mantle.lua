-----------------------------------
-- ID: 13693
-- Item: Aries Mantle
-- Enchantment: Sleep
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if
        target:hasStatusEffect(xi.effect.SLEEP_I) or
        target:hasStatusEffect(xi.effect.SLEEP_II) or
        target:hasStatusEffect(xi.effect.LULLABY)
    then
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    else
        target:addStatusEffect(xi.effect.SLEEP_I, 0, 0, 30)
    end
end

return itemObject
