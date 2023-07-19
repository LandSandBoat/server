-----------------------------------
-- ID: 4971
-- Scroll of Yain: Ichi
-- Teaches the ninjutsu Yain: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.YAIN_ICHI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.YAIN_ICHI)
end

return itemObject
