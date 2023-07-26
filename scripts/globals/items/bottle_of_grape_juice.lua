-----------------------------------
-- ID: 4441
-- Item: Grape Juice
-- Item Effect: Restores 60 MP over 90 seconds.
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if not target:hasStatusEffect(xi.effect.REFRESH) then
        target:addStatusEffect(xi.effect.REFRESH, 2, 3, 90)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
