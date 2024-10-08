-----------------------------------
-- ID: 4939
-- Scroll of Doton: San
-- Teaches the ninjutsu Doton: San
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.DOTON_SAN)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.DOTON_SAN)
end

return itemObject
