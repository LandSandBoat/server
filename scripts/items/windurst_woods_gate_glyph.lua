
-----------------------------------
-- ID: 4195
-- Windurst Woods Gate Glyph
-- Transports the user to the Windurst Woods gate
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.WINDY_WOODS_GLYPH, 0, 3)
end

return itemObject
