-----------------------------------
-- ID: 5204
-- Piece of Elvaan Mochi
-- Enchantment: 60Min, Costume - Elvaan Child (male)
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if not target:canUseMisc(xi.zoneMisc.COSTUME) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.COSTUME, 154, 0, 3600)
end

return itemObject
