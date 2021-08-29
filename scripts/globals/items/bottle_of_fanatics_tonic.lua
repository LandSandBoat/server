-----------------------------------------
-- ID: 5845
-- Item: bottle_of_fanatics_tonic
-- Item Effect: When applied, grants DMGPHYS -5000 for 60s
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
    local duration = 60
    local power = 0
    local wsmitigation = 0

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
