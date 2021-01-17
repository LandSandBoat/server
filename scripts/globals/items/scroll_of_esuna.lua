-----------------------------------------
-- ID: 4703
-- Scroll of Esuna
-- Teaches the white magic Esuna
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(95)
end

item_object.onItemUse = function(target)
    target:addSpell(95)
end

return item_object
