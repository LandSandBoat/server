-----------------------------------
-- ID: 4656
-- Scroll of Shell
-- Teaches the white magic Shell
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(48)
end

itemObject.onItemUse = function(target)
    target:addSpell(48)
end

return itemObject
