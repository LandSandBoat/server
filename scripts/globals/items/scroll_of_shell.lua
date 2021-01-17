-----------------------------------------
-- ID: 4656
-- Scroll of Shell
-- Teaches the white magic Shell
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(48)
end

item_object.onItemUse = function(target)
    target:addSpell(48)
end

return item_object
