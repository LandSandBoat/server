-----------------------------------
-- ID: 15170
-- Item: wing gorget
-- Item Effect: gives regain
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if target:hasStatusEffect(xi.effect.REGAIN) then
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    else
        target:addStatusEffect(xi.effect.REGAIN, 5, 3, 30)
    end
end

return itemObject
