-----------------------------------
-- ID: 5053
-- Scroll of Dark Carol
-- Teaches the song Dark Carol
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(445)
end

itemObject.onItemUse = function(target)
    target:addSpell(445)
end

return itemObject
