-----------------------------------------
-- ID: 4749
-- Scroll of Reraise II
-- Teaches the white magic Reraise II
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(141)
end

item_object.onItemUse = function(target)
    target:addSpell(141)
end

return item_object
