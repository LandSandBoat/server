-----------------------------------
-- ID: 4809
-- Scroll of Waterga III
-- Teaches the black magic Waterga III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(201)
end

itemObject.onItemUse = function(target)
    target:addSpell(201)
end

return itemObject
