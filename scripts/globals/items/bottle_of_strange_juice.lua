-----------------------------------
-- ID: 5438
-- Item: Bottle of Strange Juice
-- Item Effect: Restores 200 MP over 300 seconds.
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if not target:hasStatusEffect(xi.effect.REFRESH) then
        target:addStatusEffect(xi.effect.REFRESH, 2, 3, 300)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
