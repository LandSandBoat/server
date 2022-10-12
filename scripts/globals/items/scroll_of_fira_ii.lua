-----------------------------------
-- ID: 4917
-- Scroll of Fira II
-- Teaches the black magic Fira II
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FIRA_II)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FIRA_II)
end

return itemObject
