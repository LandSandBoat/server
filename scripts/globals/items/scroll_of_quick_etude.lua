-----------------------------------
-- ID: 5035
-- Scroll of Quick Etude
-- Teaches the song Quick Etude
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.QUICK_ETUDE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.QUICK_ETUDE)
end

return itemObject
