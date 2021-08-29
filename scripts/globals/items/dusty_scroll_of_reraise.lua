-----------------------------------
--  ID: 5436
--  name: dusty_scroll_of_reraise
--  effect: grants reraise III for 10m
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local buff = xi.effect.RERAISE
    local power = 3
    local duration = 600
    if target:hasStatusEffect(buff) then
        local effect = target:getStatusEffect(buff)
        local oPower = effect:getPower()
        if (oPower > power) then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:delStatusEffect(buff)
            target:addStatusEffect(buff, power, 0, duration)
        end
    else
        target:addStatusEffect(buff, power, 0, duration)
    end
end

return item_object
