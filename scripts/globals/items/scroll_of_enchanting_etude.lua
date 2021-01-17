-----------------------------------------
-- ID: 5038
-- Scroll of Enchanting Etude
-- Teaches the song Enchanting Etude
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(430)
end

item_object.onItemUse = function(target)
    target:addSpell(430)
end

return item_object
