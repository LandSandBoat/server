-----------------------------------------
-- ID: 26517
-- Item: Shadow Lord Shirt
-- Teleports user to Castle Zvahl Keep
-----------------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    -- Need retail verification: Is having set foot in the zone a requirement?
    if not target:isZoneVisited(162) then
        result = 56
    end
    return result
end

function onItemUse(target)
    -- May need a retail capture to verify actual position
    -- https://ffxiclopedia.fandom.com/wiki/Shadow_Lord_Shirt states teleports next to HP#1
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.ZVAHL_KEEP, 0, 4)
end
