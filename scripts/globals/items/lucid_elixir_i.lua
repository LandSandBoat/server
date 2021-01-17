-----------------------------------------
-- ID: 5830
-- Item: Lucid Elixir I
-- Item Effect: Restores 50% of HP and MP
-----------------------------------------
require("scripts/globals/settings")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if target:getMaxHP() == target:getHP() and target:getMaxMP() == target:getMP() then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE_2
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addHP(target:getMaxHP()*0.5*ITEM_POWER)
    target:addMP(target:getMaxMP()*0.5*ITEM_POWER)
    target:messageBasic(tpz.msg.basic.RECOVERS_HP_AND_MP)
end

return item_object
