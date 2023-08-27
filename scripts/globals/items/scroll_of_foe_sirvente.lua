-----------------------------------
-- ID: 5076
-- Scroll of Foe Sirvente
-- Teaches the song Foe Sirvente
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(468)
end

itemObject.onItemUse = function(target)
    target:addSpell(468)
end

return itemObject
