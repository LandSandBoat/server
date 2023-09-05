-----------------------------------
-- ID: 4958
-- Scroll of Dokumori: Ichi
-- Teaches the ninjutsu Dokumori: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.DOKUMORI_ICHI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DOKUMORI_ICHI)
end

return itemObject
