-----------------------------------------
-- ID: 4162
-- Item: Silencing Potion
-- Item Effect: This potion induces silence.
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (not target:hasStatusEffect(tpz.effect.SILENCE)) then
        target:addStatusEffect(tpz.effect.SILENCE, 1, 3, 180)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

return item_object
