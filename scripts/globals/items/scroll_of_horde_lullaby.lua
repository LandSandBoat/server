-----------------------------------
-- ID: 4984
-- Scroll of Horde Lullaby
-- Teaches the song Horde Lullaby
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(376)
end

itemObject.onItemUse = function(target)
    target:addSpell(376)
end

return itemObject
