-----------------------------------
-- ID:          5842
-- Item:        bottle_of_ascetics_gambir
-- Item Effect: MATK/MACC 50
-----------------------------------

local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local effect1   = xi.effect.MAGIC_ATK_BOOST
    local effect2   = xi.effect.INTENSION
    local power1    =  50 --MATT
    local power2    =  50 --MACC
    local duration  = 300

    xi.itemUtils.addTwoItemEffects(target, effect1, effect2, power1, power2, duration)
end

return itemObject
