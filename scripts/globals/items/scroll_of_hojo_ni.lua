-----------------------------------------
-- ID: 4953
-- Scroll of Hojo: Ni
-- Teaches the ninjutsu Hojo: Ni
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(345)
end

item_object.onItemUse = function(target)
    target:addSpell(345)
end

return item_object
