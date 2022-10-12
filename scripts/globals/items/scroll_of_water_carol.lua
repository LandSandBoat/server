-----------------------------------
-- ID: 5051
-- Scroll of Water Carol
-- Teaches the song Water Carol
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(443)
end

itemObject.onItemUse = function(target)
    target:addSpell(443)
end

return itemObject
