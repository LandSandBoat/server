
-----------------------------------
-- ID: 4776
-- Scroll of thunder v
-- Teaches the black magic thunder v
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.THUNDER_V)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.THUNDER_V)
end

return itemObject
