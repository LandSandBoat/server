-----------------------------------
-- ID: 4622
-- Scroll of Poisona
-- Teaches the white magic Poisona
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.POISONA)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.POISONA)
end

return itemObject
