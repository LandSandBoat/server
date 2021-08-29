-----------------------------------------
-- ID: 5243
-- Item: container_of_carnal_incense
-- Item Effect: When applied, grants UDMGPHYS -10000 for 20s
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local shieldtype = xi.effect.PHYSICAL_SHIELD
    local duration = 20
    local power = 1
    local wsmitigation = 2

    local function addShield(target, power, duration)
        target:delStatusEffect(xi.effect.MAGIC_SHIELD)
        target:addStatusEffect(shieldtype, power, 0, duration, 0, wsmitigation)
        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, shieldtype)
    end

    if target:hasStatusEffect(shieldtype) then
        local shield = target:getStatusEffect(shieldtype)
        local activeshieldpower = shield:getPower()

        if activeshieldpower > power then
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        else
            addShield(target, power, duration)
        end
    else
       addShield(target, power, duration)
    end
end

return item_object
