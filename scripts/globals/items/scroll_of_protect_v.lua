-----------------------------------
-- ID: 4655
-- Scroll of Protect V
-- Teaches the white magic Protect V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(47)
end

itemObject.onItemUse = function(target)
    target:addSpell(47)
end

return itemObject
