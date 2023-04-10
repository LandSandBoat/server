-----------------------------------
-- ID: 5014
-- Scroll of Herb Pastoral
-- Teaches the song Herb Pastoral
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(406)
end

itemObject.onItemUse = function(target)
    target:addSpell(406)
end

return itemObject
