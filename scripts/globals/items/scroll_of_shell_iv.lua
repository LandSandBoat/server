-----------------------------------
-- ID: 4659
-- Scroll of Shell IV
-- Teaches the white magic Shell IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(51)
end

itemObject.onItemUse = function(target)
    target:addSpell(51)
end

return itemObject
