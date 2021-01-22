-----------------------------------
-- ID: 4182
--  Scroll of Instant ReRaise
--  Brings you back from the dead~!
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
    if (target:hasStatusEffect(tpz.effect.RERAISE)) then
        local effect = target:getStatusEffect(tpz.effect.RERAISE)
        local oPower = effect:getPower()
        if (oPower > power) then
            target:messageBasic(tpz.msg.basic.NO_EFFECT)
        else
            target:delStatusEffect(tpz.effect.RERAISE)
            target:addStatusEffect(tpz.effect.RERAISE, power, 0, duration)
        end
    else
        target:addStatusEffect(tpz.effect.RERAISE, power, 0, duration)
    end
end

return item_object
