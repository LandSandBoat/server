-----------------------------------
-- ID: 4945
-- Scroll of Suiton: San
-- Teaches the ninjutsu Suiton: San
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.SUITON_SAN)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.SUITON_SAN)
end

return itemObject
