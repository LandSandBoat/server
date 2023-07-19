-----------------------------------
-- ID: 4961
-- Scroll of Tonko: Ichi
-- Teaches the ninjutsu Tonko: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.TONKO_ICHI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.TONKO_ICHI)
end

return itemObject
