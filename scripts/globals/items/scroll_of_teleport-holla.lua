-----------------------------------
-- ID: 4730
-- Scroll of Teleport-Holla
-- Teaches the white magic Teleport-Holla
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(122)
end

itemObject.onItemUse = function(target)
    target:addSpell(122)
end

return itemObject
