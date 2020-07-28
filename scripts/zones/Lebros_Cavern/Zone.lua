-----------------------------------
--
-- Zone: Lebros_Cavern
--
-----------------------------------
require("scripts/zones/Lebros_Cavern/IDs")
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
    player:addTempItem(5345)

    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 102) then
        player:setPos(0, 0, 0, 0, 61)
    end
end

function onInstanceLoadFailed()
    return 61
end
