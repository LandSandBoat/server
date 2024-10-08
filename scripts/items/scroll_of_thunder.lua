-----------------------------------
-- ID: 4772
-- Scroll of Thunder
-- Teaches the black magic Thunder
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.THUNDER)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.THUNDER)
end

return itemObject
