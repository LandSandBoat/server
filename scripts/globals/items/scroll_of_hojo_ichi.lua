-----------------------------------
-- ID: 4952
-- Scroll of Hojo: Ichi
-- Teaches the ninjutsu Hojo: Ichi
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.HOJO_ICHI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.HOJO_ICHI)
end

return itemObject
