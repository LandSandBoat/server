-----------------------------------
-- ID: 4902
-- Light Spirit Pact
-- Teaches the summoning magic Air Spirit
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.LIGHT_SPIRIT)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.LIGHT_SPIRIT)
end

return itemObject
