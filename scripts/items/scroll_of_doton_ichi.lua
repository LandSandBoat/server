-----------------------------------
-- ID: 4937
-- Scroll of Doton: Ichi
-- Teaches the ninjutsu Doton: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.DOTON_ICHI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DOTON_ICHI)
end

return itemObject
