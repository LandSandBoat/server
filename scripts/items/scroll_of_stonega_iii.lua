-----------------------------------
-- ID: 4799
-- Scroll of Stonega III
-- Teaches the black magic Stonega III
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.STONEGA_III)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.STONEGA_III)
end

return itemObject
