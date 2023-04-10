-----------------------------------
-- ID: 4744
-- Scroll of Invisible
-- Teaches the white magic Invisible
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(136)
end

itemObject.onItemUse = function(target)
    target:addSpell(136)
end

return itemObject
