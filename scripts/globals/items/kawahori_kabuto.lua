-----------------------------------
-- ID: 16071
-- Item: kawahori_kabuto
-- Effect: blindness
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if not target:hasStatusEffect(xi.effect.BLINDNESS) then
        target:addStatusEffect(xi.effect.BLINDNESS, 25, 0, 180)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return item_object
