-----------------------------------
-- ID: 4931
-- Scroll of Hyoton: Ichi
-- Teaches the ninjutsu Hyoton: Ichi
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return target:canLearnSpell(xi.magic.spell.HYOTON_ICHI)
end

itemObject.onItemUse = function(target)
    target:addSpell(xi.magic.spell.HYOTON_ICHI)
end

return itemObject
