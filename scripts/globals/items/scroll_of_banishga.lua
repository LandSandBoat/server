-----------------------------------
-- ID: 4646
-- Scroll of Banishga
-- Teaches the white magic Banishga
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(38)
end

itemObject.onItemUse = function(target)
    target:addSpell(38)
end

return itemObject
