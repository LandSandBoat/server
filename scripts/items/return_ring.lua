-----------------------------------
-- ID: 15542
-- Teleport Return Ring
-- Enchantment: "Outpost Warp"
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local result = 0
    local region = target:getCurrentRegion()

    if
        not xi.conquest.canTeleportToOutpost(target, region) or
        GetRegionOwner(region) ~= target:getNation()
    then
        result = xi.msg.basic.CANT_BE_USED_IN_AREA
    end

    return result
end

itemObject.onItemUse = function(target, user)
    local region = target:getCurrentRegion()
    target:addStatusEffect(xi.effect.TELEPORT, { power = xi.teleport.id.OUTPOST, duration = 4, origin = user, icon = 0, subPower = region })
end

return itemObject
