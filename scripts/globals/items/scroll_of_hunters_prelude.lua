-----------------------------------
-- ID: 5009
-- Scroll of Hunters Prelude
-- Teaches the song Hunters Prelude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(401)
end

itemObject.onItemUse = function(target)
    target:addSpell(401)
end

return itemObject
