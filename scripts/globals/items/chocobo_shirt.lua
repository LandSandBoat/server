-----------------------------------------
-- ID: 10293
-- Chocobo Shirt
-- Dispense: Crystals
-----------------------------------------
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    if target:getFreeSlotsCount() == 0 then
        result = tpz.msg.basic.ITEM_NO_USE_INVENTORY
    end
    return result
end

function onItemUse(target)
    local day = VanadielDayElement()+1
    local crystal =
    {
        4096, -- Fire
        4099, -- Earth
        4101, -- Water
        4098, -- Wind
        4097, -- Ice
        4100, -- Thunder
        4102, -- Light
        4103  -- Dark
    }
    -- print(crystal[day])
    target:addItem(crystal[day], math.random(2, 12))
end
