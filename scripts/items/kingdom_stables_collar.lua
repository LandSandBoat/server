-----------------------------------
-- ID: 13179
-- Item: Kingdom Stables Collar
-- Teleports to Chocobo Stables (San d'Oria)
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if not target:hasVisitedZone(230) then
        result = 56
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.CHOCO_SANDORIA, 0, 4)
end

return itemObject
