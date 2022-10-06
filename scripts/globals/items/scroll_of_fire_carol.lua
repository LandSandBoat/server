-----------------------------------
-- ID: 5046
-- Scroll of Fire Carol
-- Teaches the song Fire Carol
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(438)
end

itemObject.onItemUse = function(target)
    target:addSpell(438)
end

return itemObject
