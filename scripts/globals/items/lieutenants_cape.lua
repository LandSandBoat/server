-----------------------------------------
-- ID: 16230
-- Item: Lieutenant's Cape
-- Item Effect: Restores 50% hp and 25% mp
-----------------------------------------
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    target:addHP((target:getMaxHP()/100)*50)
    target:addMP((target:getMaxMP()/100)*25)
    target:messageBasic(tpz.msg.basic.RECOVERS_HP_AND_MP)
end

return item_object
