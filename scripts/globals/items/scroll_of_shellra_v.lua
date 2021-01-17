-----------------------------------------
-- ID: 4742
-- Scroll of Shellra V
-- Teaches the white magic Shellra V
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(134)
end

item_object.onItemUse = function(target)
    target:addSpell(134)
end

return item_object
