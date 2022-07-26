-----------------------------------
-- ID: 5988
--  Scroll of Instant Protect
--  Grants the effect of Protect
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local power = 1
    local duration = 1800
    if (target:hasStatusEffect(xi.effect.PROTECT)) then
        local effect = target:getStatusEffect(xi.effect.PROTECT)
        local oPower = effect:getPower()
        if (oPower > power) then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:delStatusEffect(xi.effect.PROTECT)
            target:addStatusEffect(xi.effect.PROTECT, power, 0, duration)
        end
    else
        target:addStatusEffect(xi.effect.PROTECT, power, 0, duration)
    end
end

return item_object