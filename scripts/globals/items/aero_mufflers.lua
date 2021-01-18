-----------------------------------
-- ID: 14989
-- Aero Mufflers
--  Enchantment: "Enaero"
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local effect = tpz.effect.ENAERO
    doEnspell(target, target, nil, effect)
end

return item_object
