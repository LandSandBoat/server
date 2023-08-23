-----------------------------------
-- ID: 5076
-- Scroll of Foe Sirvente
-- Teaches the song Foe Sirvente
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FOE_SIRVENTE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FOE_SIRVENTE)
end

return itemObject
