-----------------------------------
-- ID: 4187
-- Bastok Mines Gate Glyph
-- Transports the user to the Bastok Mines gate
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.BASTOK_MINES_GLYPH, duration = 3, origin = user, icon = 0 })
end

return itemObject
