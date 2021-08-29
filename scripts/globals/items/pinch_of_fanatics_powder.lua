-----------------------------------------
-- ID: 5847
-- Item: pinch_of_fanatics_powder
-- Item Effect: When applied, grants UDMGPHYS -10000 to party members in range for 60s
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
    local power = 1
    local wsmitigation = 1

    local function addShield(target, power, duration)
        target:delStatusEffect(xi.effect.MAGIC_SHIELD)
        target:addStatusEffect(shieldtype, power, 0, duration, 0, wsmitigation)
        target:messageBasic(xi.msg.basic.GAINS_EFFECT_OF_STATUS, shieldtype)
    end
    
    target:forMembersInRange(30, function(member)
        if member:hasStatusEffect(shieldtype) then
            local shield = member:getStatusEffect(shieldtype)
            local activeshieldpower = shield:getPower()

            if activeshieldpower > power then
                member:messageBasic(xi.msg.basic.NO_EFFECT)
            else
                addShield(member, power, duration)
            end
        else
            addShield(member, power, duration)
        end
    end)
end

return item_object
