-----------------------------------
-- ID: 4935
-- Scroll of Huton: Ni
-- Teaches the ninjutsu Huton: Ni
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.HUTON_NI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.HUTON_NI)
end

return itemObject
