-----------------------------------
-- ID: 4742
-- Scroll of Shellra V
-- Teaches the white magic Shellra V
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(134)
end

itemObject.onItemUse = function(target)
    target:addSpell(134)
end

return itemObject
