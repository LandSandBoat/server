-----------------------------------
-- ID: 4929
-- Scroll of Katon: Ni
-- Teaches the ninjutsu Katon: Ni
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.KATON_NI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.KATON_NI)
end

return itemObject
