-----------------------------------
-- ID: 5030
-- Scroll of Carnage Elegy
-- Teaches the song Carnage Elegy
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.CARNAGE_ELEGY)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.CARNAGE_ELEGY)
end

return itemObject
