-----------------------------------------
-- ID: 5852
-- Item: bottle_of_swiftshot_tonic
-- Item Effect: Double Shot +50
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local ename = xi.effect.MULTI_SHOTS
    local power = 50 --Double Shot Rate
    local duration = 60

    if target:hasStatusEffect(ename) then
        local buff = target:getStatusEffect(ename)
        local effectpower = buff:getPower()
        if effectpower > power then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(ename, power, 0, duration, 0, 0)
        end
    else
        target:addStatusEffect(ename, power, 0, duration, 0, 0)
    end
end

return item_object
