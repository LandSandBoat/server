-----------------------------------
-- ID: 5437
-- Item: Flask of Strange Milk
-- Item Effect: Restores 500 HP over 300 seconds.
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if not target:hasStatusEffect(xi.effect.REGEN) then
        target:addStatusEffect(xi.effect.REGEN, 5, 3, 300)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
