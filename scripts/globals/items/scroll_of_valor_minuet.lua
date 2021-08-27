-----------------------------------
-- ID: 5002
-- Scroll of Valor Minuet
-- Teaches the song Valor Minuet
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(394)
end

item_object.onItemUse = function(target)
    target:addSpell(394)
end

return item_object
