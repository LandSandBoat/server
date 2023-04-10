-----------------------------------
-- ID: 5067
-- Scroll of Water Threnody
-- Teaches the song Water Threnody
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(459)
end

itemObject.onItemUse = function(target)
    target:addSpell(459)
end

return itemObject
