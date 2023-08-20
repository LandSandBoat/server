-----------------------------------
-- ID: 4964
-- Scroll of Monomi: Ichi
-- Teaches the ninjutsu Monomi: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.MONOMI_ICHI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.MONOMI_ICHI)
end

return itemObject
