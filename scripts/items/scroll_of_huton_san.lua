-----------------------------------
-- ID: 4936
-- Scroll of Huton: San
-- Teaches the ninjutsu Huton: San
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.HUTON_SAN)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.HUTON_SAN)
end

return itemObject
