-----------------------------------
-- ID: 5086
-- Scroll of Regen V
-- Teaches the white magic Regen V
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.REGEN_V)
end

item_object.onItemUse = function(target)
    target:addSpell(xi.magic.spell.REGEN_V)
end

return item_object
