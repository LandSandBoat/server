-----------------------------------
-- ID: 13181
-- Item: Federation Stables Scarf
-- Teleports to Chocobo Stables (Windurst)
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local result = 0
    if not target:isZoneVisited(241) then
        result = 56
    end
    return result
end

item_object.onItemUse = function(target)
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.CHOCO_WINDURST, 0, 4)
end

return item_object
