-----------------------------------
-- ID: 4962
-- Scroll of Tonko: Ichi
-- Teaches the ninjutsu Tonko: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.TONKO_NI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.TONKO_NI)
end

return itemObject
