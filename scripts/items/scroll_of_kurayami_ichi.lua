-----------------------------------
-- ID: 4955
-- Scroll of Kurayami: Ichi
-- Teaches the ninjutsu Kurayami: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.KURAYAMI_ICHI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.KURAYAMI_ICHI)
end

return itemObject
