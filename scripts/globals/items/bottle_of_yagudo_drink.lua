-----------------------------------
-- ID: 4558
-- Item: Yagudo Drink
-- Item Effect: Restores 120 MP over 3 minutes
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if not target:hasStatusEffect(xi.effect.REFRESH) then
        target:addStatusEffect(xi.effect.REFRESH, 2, 3, 180)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
