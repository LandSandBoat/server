-----------------------------------------
-- ID: 4724
-- Scroll of Enaero II
-- Teaches the white magic Enaero II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(314)
end

item_object.onItemUse = function(target)
    target:addSpell(314)
end

return item_object
