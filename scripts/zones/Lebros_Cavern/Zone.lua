-----------------------------------
-- Zone: Lebros_Cavern
-----------------------------------
require('scripts/zones/Lebros_Cavern/IDs')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onInstanceZoneIn = function(player, instance)
    local cs = -1

    if player:getInstance() == nil then
        player:setPos(0, 0, 0, 0, xi.zone.MOUNT_ZHAYOLM)
        return cs
    end

    local pos = player:getPos()
    if pos.x == 0 and pos.y == 0 and pos.z == 0 then
        local entrypos = instance:getEntryPos()
        player:setPos(entrypos.x, entrypos.y, entrypos.z, entrypos.rot)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 102 then
        local instance = player:getInstance()
        local chars = instance:getChars()

        for _, entity in pairs(chars) do
            entity:setPos(0, 0, 0, 0, xi.zone.MOUNT_ZHAYOLM)
        end
    end
end

zoneObject.onInstanceLoadFailed = function()
    return 61
end

return zoneObject
