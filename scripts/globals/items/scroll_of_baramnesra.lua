-----------------------------------
-- ID: 4691
-- Scroll of Baramnesra
-- Teaches the white magic Baramnesra
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(85)
end

item_object.onItemUse = function(target)
    target:addSpell(85)
end

return item_object
