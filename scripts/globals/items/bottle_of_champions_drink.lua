-----------------------------------------
-- ID: 5392
-- Item: bottle_of_champions_drink
-- Item Effect: Haste (Magic) 18% - CRITHITRATE 5%
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local ename = xi.effect.POTENCY
    local power = 1800  --haste
    local subp  = 5     --crit
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
