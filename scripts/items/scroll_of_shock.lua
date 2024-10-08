-----------------------------------
-- ID: 4847
-- Scroll of Shock
-- Teaches the black magic Shock
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.SHOCK)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SHOCK)
end

return itemObject
