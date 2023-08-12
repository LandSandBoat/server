-----------------------------------
-- ID: 5297
-- Mithran Rice Cake
-- Enchantment: 60Min, Costume - Mithra Child
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if not target:canUseMisc(xi.zoneMisc.COSTUME) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.COSTUME, 182, 0, 3600)
end

return itemObject
