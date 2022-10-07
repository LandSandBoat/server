-----------------------------------
-- ID: 5010
-- Scroll of Archers Prelude
-- Teaches the song Archers Prelude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(402)
end

itemObject.onItemUse = function(target)
    target:addSpell(402)
end

return itemObject
