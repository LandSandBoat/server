-----------------------------------
-- ID: 22069
-- Hapy Staff
-- Enchantment: 60Min, Costume - Frog (Various)
-----------------------------------
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
    local costumes =
    {
        [1] = 1811, -- Poroggo (Green)
        [2] = 1812, -- Toad (Green)
        [3] = 1813, -- Poroggo (Red)
        [4] = 2951, -- Squib
        --[[
            Server Operators seeking additional variety:
            2666: Toad (Red)
            2098: Toad (Blue)
            3598: Poroggo (Purple)
        --]]
    }

    local id = math.random(1, 4)

    target:addStatusEffect(xi.effect.COSTUME, costumes[id], 0, 3600)
end

return itemObject
