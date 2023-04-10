-----------------------------------
-- ID: 5037
-- Scroll of Spirited Etude
-- Teaches the song Spirited Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(429)
end

itemObject.onItemUse = function(target)
    target:addSpell(429)
end

return itemObject
