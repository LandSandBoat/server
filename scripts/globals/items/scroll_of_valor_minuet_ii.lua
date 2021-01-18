-----------------------------------
-- ID: 5003
-- Scroll of Valor Minuet II
-- Teaches the song Valor Minuet II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(395)
end

item_object.onItemUse = function(target)
    target:addSpell(395)
end

return item_object
