-----------------------------------------
-- ID: 4606
-- Scroll of Dia
-- Teaches the white magic Dia
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(23)
end

item_object.onItemUse = function(target)
    target:addSpell(23)
end

return item_object
