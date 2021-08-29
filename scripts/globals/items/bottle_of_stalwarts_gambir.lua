-----------------------------------------
-- ID: 5840
-- Item: bottle_of_stalwarts_gambir
-- Item Effect: ACC 100 RACC 100 RATTP 50 ATTP 50
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------

local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local name1 = xi.effect.ACCURACY_BOOST
    local name2 = xi.effect.ATTACK_BOOST
    local power1 = 100 --ACC/RACC
    local power2 = 50 --ATTP/RATTP
    local duration = 300

    if target:hasStatusEffect(name1) then
        local buff = target:getStatusEffect(name1)
        local effectpower = buff:getPower()
        if effectpower > power1 then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(name1, power1, 0, duration, 0, power1)
        end
    else
        target:addStatusEffect(name1, power1, 0, duration, 0, power1)
    end

    if target:hasStatusEffect(name2) then
        local buff = target:getStatusEffect(name2)
        local effectpower = buff:getPower()
        if effectpower > power2 then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            target:addStatusEffect(name2, power2, 0, duration, 0, power2)
        end
    else
        target:addStatusEffect(name2, power2, 0, duration, 0, power2)
    end
end

return item_object
