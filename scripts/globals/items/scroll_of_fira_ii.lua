-----------------------------------
-- ID: 4917
-- Scroll of Fira II
-- Teaches the black magic Fira II
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.FIRA_II)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.FIRA_II)
end

return item_object
