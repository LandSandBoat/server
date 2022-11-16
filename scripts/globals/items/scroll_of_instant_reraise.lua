-----------------------------------
-- ID: 4182
--  Scroll of Instant ReRaise
--  Brings you back from the dead~!
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local power = 1
    local duration = 1800
    if target:hasStatusEffect(xi.effect.RERAISE) then
        local effect = target:getStatusEffect(xi.effect.RERAISE)
        local oPower = effect:getPower()
        if oPower > power then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:delStatusEffect(xi.effect.RERAISE)
            target:addStatusEffect(xi.effect.RERAISE, power, 0, duration)
        end
    else
        target:addStatusEffect(xi.effect.RERAISE, power, 0, duration)
    end
end

return itemObject
