-----------------------------------
-- ID: 15929
-- Goblin Belt
-- Enchantment: 60Min, Costume - Goblin (dagger)
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if not target:canUseMisc(xi.zoneMisc.COSTUME) then
        return xi.msg.basic.CANT_BE_USED_IN_AREA
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.COSTUME, 673, 0, 3600)
end

return itemObject
