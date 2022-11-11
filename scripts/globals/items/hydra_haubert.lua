-----------------------------------
-- ID: 14517
-- Item: Hydra Haubert
-- Item Effect: gives refresh
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if target:hasStatusEffect(xi.effect.REFRESH) then
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    else
        target:addStatusEffect(xi.effect.REFRESH, 3, 3, 180)
    end
end

return itemObject
