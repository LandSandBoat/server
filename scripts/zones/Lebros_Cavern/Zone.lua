-----------------------------------
-- Zone: Lebros_Cavern
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onInstanceZoneIn = function(player, instance)
    if player:getInstance() == nil then
        player:setPos(0, 0, 0, 0, xi.zone.MOUNT_ZHAYOLM)
        return
    end

    local pos = player:getPos()
    if pos.x == 0 and pos.y == 0 and pos.z == 0 then
        local entrypos = instance:getEntryPos()
        player:setPos(entrypos.x, entrypos.y, entrypos.z, entrypos.rot)
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 102 then
        local instance = player:getInstance()
        if not instance then
            return
        end

        local chars = instance:getChars()

        for _, entity in pairs(chars) do
            entity:setPos(0, 0, 0, 0, xi.zone.MOUNT_ZHAYOLM)
        end
    end
end

zoneObject.onInstanceLoadFailed = function()
    return xi.zone.MOUNT_ZHAYOLM
end

return zoneObject
