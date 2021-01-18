-----------------------------------
-- ID: 4942
-- Scroll of Raiton: San
-- Teaches the ninjutsu Raiton: San
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(334)
end

item_object.onItemUse = function(target)
    target:addSpell(334)
end

return item_object
