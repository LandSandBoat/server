-----------------------------------
-- ID: 4986
-- Scroll of Armys Paeton
-- Teaches the song Armys Paeton
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(378)
end

itemObject.onItemUse = function(target)
    target:addSpell(378)
end

return itemObject
