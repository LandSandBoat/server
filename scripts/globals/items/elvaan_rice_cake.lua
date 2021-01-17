-----------------------------------------
-- ID: 5295
-- Elvaan Rice Cake
-- Enchantment: 60Min, Costume - Elvaan Child (female)
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    if not target:canUseMisc(tpz.zoneMisc.COSTUME) then
        return tpz.msg.basic.CANT_BE_USED_IN_AREA
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.COSTUME, 158, 0, 3600)
end

return item_object
