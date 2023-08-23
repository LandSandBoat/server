-----------------------------------
-- ID: 4719
-- Scroll of Regen III
-- Teaches the white magic Regen III
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return target:canLearnSpell(xi.magic.spell.REGEN_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.REGEN_III)
end

return itemObject
