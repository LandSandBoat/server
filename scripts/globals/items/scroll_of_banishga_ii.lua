-----------------------------------
-- ID: 4647
-- Scroll of Banishga II
-- Teaches the white magic Banishga II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(39)
end

itemObject.onItemUse = function(target)
    target:addSpell(39)
end

return itemObject
