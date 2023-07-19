-----------------------------------
-- ID: 4938
-- Scroll of Doton: ni
-- Teaches the ninjutsu Doton: ni
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.DOTON_NI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DOTON_NI)
end

return itemObject
