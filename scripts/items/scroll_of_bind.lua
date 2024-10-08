-----------------------------------
-- ID: 4866
-- Scroll of Bind
-- Teaches the black magic Bind
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.BIND)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.BIND)
end

return itemObject
