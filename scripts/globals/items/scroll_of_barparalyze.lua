-----------------------------------------
-- ID: 4682
-- Scroll of Barparalyze
-- Teaches the white magic Barparalyze
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(74)
end

item_object.onItemUse = function(target)
    target:addSpell(74)
end

return item_object
