
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

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.WINDY_WOODS_GLYPH, duration = 3, origin = user, icon = 0 })
end

return itemObject
