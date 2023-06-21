-----------------------------------
-- ID: 4423
-- Item: Apple Juice
-- Item Effect: Restores 45 MP over 135 seconds.
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if not target:hasStatusEffect(xi.effect.REFRESH) then
        target:addStatusEffect(xi.effect.REFRESH, 1, 3, 135)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
