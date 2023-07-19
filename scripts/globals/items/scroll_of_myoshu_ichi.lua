-----------------------------------
-- ID: 4966
-- Scroll of Myoshu: Ichi
-- Teaches the ninjutsu Myoshu: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.MYOSHU_ICHI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.MYOSHU_ICHI)
end

return itemObject
