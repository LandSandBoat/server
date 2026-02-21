-----------------------------------
-- ID: 5428
-- Scroll of Instant Retrace
-- Transports the user to their Allied Nation.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    if target:getCampaignAllegiance() == 0 then
        return 56
    else
        return 0
    end
end

itemObject.onItemUse = function(target, user)
    if target:getCampaignAllegiance() > 0 then
        target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.RETRACE, duration = 3, origin = user, icon = 0 })
    end
end

return itemObject
