-----------------------------------
-- ID: 5933
-- Item: Flask of Dragon Fruit au Lait
-- Item Effect: Restores 600 HP over 300 seconds
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if not target:hasStatusEffect(xi.effect.REGEN) then
        target:addStatusEffect(xi.effect.REGEN, 6, 3, 300)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
