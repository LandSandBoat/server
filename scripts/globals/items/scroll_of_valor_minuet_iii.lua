-----------------------------------
-- ID: 5004
-- Scroll of Valor Minuet III
-- Teaches the song Valor Minuet III
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(396)
end

item_object.onItemUse = function(target)
    target:addSpell(396)
end

return item_object
