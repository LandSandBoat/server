-----------------------------------
-- ID: 4871
-- Scroll of Escape
-- Teaches the black magic Escape
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(263)
end

itemObject.onItemUse = function(target)
    target:addSpell(263)
end

return itemObject
