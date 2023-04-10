-----------------------------------
-- ID: 4654
-- Scroll of Protect IV
-- Teaches the white magic Protect IV
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(46)
end

itemObject.onItemUse = function(target)
    target:addSpell(46)
end

return itemObject
