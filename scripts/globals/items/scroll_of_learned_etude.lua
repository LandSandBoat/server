-----------------------------------
-- ID: 5036
-- Scroll of Learned Etude
-- Teaches the song Learned Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(428)
end

itemObject.onItemUse = function(target)
    target:addSpell(428)
end

return itemObject
