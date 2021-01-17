-----------------------------------------
-- ID: 15290
-- Item: Haste Belt
-- Item Effect: 10% haste
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if not target:hasStatusEffect(tpz.effect.HASTE) then
        target:addStatusEffect(tpz.effect.HASTE, 1000, 0, 180)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end

return item_object
