-----------------------------------------
-- ID: 4213
-- Icarus Wing
-- Increases TP of the user by 100
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if (target:hasStatusEffect(tpz.effect.MEDICINE)) then
        return tpz.msg.basic.ITEM_NO_USE_MEDICATED
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addTP(1000)
    target:addStatusEffect(tpz.effect.MEDICINE, 0, 0, 7200)
end

return item_object
