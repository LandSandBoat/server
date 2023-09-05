-----------------------------------
-- ID: 4953
-- Scroll of Hojo: Ni
-- Teaches the ninjutsu Hojo: Ni
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.HOJO_NI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.HOJO_NI)
end

return itemObject
