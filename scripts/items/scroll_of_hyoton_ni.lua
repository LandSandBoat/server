-----------------------------------
-- ID: 4931
-- Scroll of Hyoton: Ni
-- Teaches the ninjutsu Hyoton: Ni
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.HYOTON_NI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.HYOTON_NI)
end

return itemObject
