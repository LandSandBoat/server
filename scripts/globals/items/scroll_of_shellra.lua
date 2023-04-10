-----------------------------------
-- ID: 4738
-- Scroll of Shellra
-- Teaches the white magic Shellra
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(130)
end

itemObject.onItemUse = function(target)
    target:addSpell(130)
end

return itemObject
