-----------------------------------
-- ID: 4932
-- Scroll of Hyoton: San
-- Teaches the ninjutsu Hyoton: San
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.HYOTON_SAN)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.HYOTON_SAN)
end

return itemObject
