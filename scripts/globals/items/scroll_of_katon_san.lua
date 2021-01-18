-----------------------------------
-- ID: 4930
-- Scroll of Katon: San
-- Teaches the ninjutsu Katon: San
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(322)
end

item_object.onItemUse = function(target)
    target:addSpell(322)
end

return item_object
