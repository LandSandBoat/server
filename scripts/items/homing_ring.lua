-----------------------------------
-- ID: 15541
-- Teleport Homing Ring
-- Enchantment: "Outpost Warp"
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    local region = target:getCurrentRegion()

    if
        not xi.conq.canTeleportToOutpost(target, region) or
        GetRegionOwner(region) ~= target:getNation()
    then
        result = xi.msg.basic.CANT_BE_USED_IN_AREA
    end

    return result
end

itemObject.onItemUse = function(target)
    local region = target:getCurrentRegion()
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.OUTPOST, 0, 1, 0, region)
end

return itemObject
