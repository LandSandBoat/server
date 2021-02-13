-----------------------------------
-- ID: 4809
-- Scroll of Waterga III
-- Teaches the black magic Waterga III
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(201)
end

item_object.onItemUse = function(target)
    target:addSpell(201)
end

return item_object
