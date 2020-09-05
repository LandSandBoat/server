-----------------------------------
--
-- Zone: Leujaoam_Sanctum
--
-----------------------------------
require("scripts/zones/Leujaoam_Sanctum/IDs")
-----------------------------------

function onInitialize(zone)
end

function onInstanceZoneIn(player, instance)
    local cs = -1

    local pos = player:getPos()
    if (pos.x == 0 and pos.y == 0 and pos.z == 0) then
        local entrypos = instance:getEntryPos()
        player:setPos(entrypos.x, entrypos.y, entrypos.z, entrypos.rot)
    end

    player:addTempItem(5343)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 102) then
        player:setPos(0, 0, 0, 0, 79)
    end
end

function onInstanceLoadFailed()
    return 79
end
