-----------------------------------------
-- ID: 11273
-- Item: custom gilet +1
-- Teleport's user to Purgonorgo Isle
-----------------------------------------

require("scripts/globals/teleports")

function onItemCheck(target)
    local result = 0
    if (target:isZoneVisited(4) == false) then
        result = 56
    end
    return result
end

function onItemUse(target)
    tpz.teleport.to(target, tpz.teleport.id.PURGONORGO)
end
