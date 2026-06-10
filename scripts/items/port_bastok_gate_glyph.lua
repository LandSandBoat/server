-----------------------------------
-- ID: 4189
-- Port Bastok Gate Glyph
-- Transports the user to the Port Bastok gate
-- (near Flying Axe, I.M.)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.PORT_BASTOK_GLYPH, duration = 3, origin = user, icon = 0 })
end

return itemObject
