-----------------------------------
-- ID: 5989
--  Scroll of Instant Shell
--  Grants the effect of Shell
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
    if (target:hasStatusEffect(xi.effect.SHELL)) then
        local effect = target:getStatusEffect(xi.effect.SHELL)
        local oPower = effect:getPower()
        if (oPower > power) then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:delStatusEffect(xi.effect.SHELL)
            target:addStatusEffect(xi.effect.SHELL, power, 0, duration)
        end
    else
        target:addStatusEffect(xi.effect.SHELL, power, 0, duration)
    end
end

return item_object