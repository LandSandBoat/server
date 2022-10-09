-----------------------------------
-- ID: 15290
-- Item: Hydra Tights
-- Item Effect: 10% haste
-- Duration: 3 minutes
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.HASTE)
    if effect ~= nil and effect:getSubType() == 15596 then
        target:delStatusEffect(xi.effect.HASTE)
    end
    return 0
end

item_object.onItemUse = function(target)
    if not target:hasStatusEffect(xi.effect.HASTE) then
        target:addStatusEffect(xi.effect.HASTE, 1000, 0, 180, 15596)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return item_object
