-----------------------------------
-- ID: 15170
-- Item: Stoneskin Torque
-- Item Effect: Stoneskin
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.STONESKIN)
    if effect ~= nil and effect:getItemSourceID() == 15170 then
        target:delStatusEffect(xi.effect.STONESKIN)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:addStatusEffect(xi.effect.STONESKIN, 104, 0, 300, 15170, 0, 4) then
        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, xi.effect.STONESKIN)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
