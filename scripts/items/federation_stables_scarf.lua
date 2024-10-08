-----------------------------------
-- ID: 13181
-- Item: Federation Stables Scarf
-- Teleports to Chocobo Stables (Windurst)
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    local result = 0
    if not target:hasVisitedZone(241) then
        result = 56
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.CHOCO_WINDURST, 0, 4)
end

return itemObject
