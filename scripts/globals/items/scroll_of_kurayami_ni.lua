-----------------------------------
-- ID: 4956
-- Scroll of Kurayami: Ni
-- Teaches the ninjutsu Kurayami: Ni
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.KURAYAMI_NI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.KURAYAMI_NI)
end

return itemObject
