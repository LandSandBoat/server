-----------------------------------------
-- ID: 5851
-- Item: bottle_of_berserkers_tonic
-- Item Effect: Double Attack +50
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local ename = xi.effect.MULTI_STRIKES
    local power = 50 --DA
    local duration = 60

    if target:hasStatusEffect(ename) then
        local buff = target:getStatusEffect(ename)
        local effectpower = buff:getPower()
        if effectpower > power then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(ename, power, 0, duration, 0, subp)
        end
    else
        target:addStatusEffect(ename, power, 0, duration, 0, subp)
    end
end

return item_object
