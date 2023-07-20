-----------------------------------
-- ID: 4703
-- Scroll of Esuna
-- Teaches the white magic Esuna
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.ESUNA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.ESUNA)
end

return itemObject
