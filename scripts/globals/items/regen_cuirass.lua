-----------------------------------
-- ID: 13823
-- Item: regen cuirass
-- Item Effect: gives regen
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.REGEN)
    if effect ~= nil and effect:getItemSourceID() == xi.items.REGEN_CUIRASS then
        target:delStatusEffect(xi.effect.REGEN)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasStatusEffect(xi.effect.REGEN) then
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    else
        target:addStatusEffect(xi.effect.REGEN, 5, 3, 75, 0, 0, 0, xi.items.REGEN_CUIRASS)
    end
end

return itemObject
