-----------------------------------------
-- ID: 4422
-- Item: Orange Juice
-- Item Effect: Restores 30 MP over 1 minute and 30 seconds.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local power = 1
    local legs = target:getEquipID(tpz.slot.LEGS)
    if (legs == 11966 or legs == 11968) then -- Dream Trousers +1 & Dream Pants +1
        power = power + 1
    end
    if (not target:hasStatusEffect(tpz.effect.REFRESH)) then
        target:addStatusEffect(tpz.effect.REFRESH, power, 3, 90)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

return item_object
