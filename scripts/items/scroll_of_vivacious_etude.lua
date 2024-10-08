-----------------------------------
-- ID: 5034
-- Scroll of Vivacious Etude
-- Teaches the song Vivacious Etude
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.VIVACIOUS_ETUDE)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.VIVACIOUS_ETUDE)
end

return itemObject
