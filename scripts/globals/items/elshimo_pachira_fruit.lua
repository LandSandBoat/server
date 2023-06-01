-----------------------------------
-- ID: 5604
-- Item: Elshimo Pachira Fruit
-- Item Effect:  Poison 1HP / Removes 40 HP over 120 seconds
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if not target:hasStatusEffect(xi.effect.POISON) then
        target:addStatusEffect(xi.effect.POISON, 1, 3, 120)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
