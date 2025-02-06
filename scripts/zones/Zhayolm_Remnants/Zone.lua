-----------------------------------
-- Zone: Zhayolm_Remnants
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCylindricalTriggerArea(1, 420, -340, 4)
    zone:registerCylindricalTriggerArea(2, 420, -500, 4)
    zone:registerCylindricalTriggerArea(3, 260, -500, 4)
    zone:registerCylindricalTriggerArea(4, 260, -340, 4)
    zone:registerCylindricalTriggerArea(5, 340, -60, 4)
    zone:registerCylindricalTriggerArea(6, 340, 420, 4)
    zone:registerCylindricalTriggerArea(7, 340, 500, 4)
    zone:registerCylindricalTriggerArea(8, -380, -620, 4)
    zone:registerCylindricalTriggerArea(9, -300, -460, 4)
    zone:registerCylindricalTriggerArea(10, -340, -100, 4)
    zone:registerCylindricalTriggerArea(11, -340, 140, 4)
    zone:registerCylindricalTriggerArea(12, -380, 500, 4)
    zone:registerCylindricalTriggerArea(13, -380, 500, 4)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    return cs
end

zoneObject.onInstanceZoneIn = function(player, instance)
    if player:getInstance() == nil then
        player:setPos(-580, 0, -433, 64, xi.zone.ALZADAAL_UNDERSEA_RUINS)
        return
    end

    local pos = player:getPos()
    if pos.x == 0 and pos.y == 0 and pos.z == 0 then
        local entrypos = instance:getEntryPos()
        player:setPos(entrypos.x, entrypos.y, entrypos.z, entrypos.rot)
        player:startEvent(101)
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

zoneObject.onInstanceLoadFailed = function()
    return xi.zone.ALZADAAL_UNDERSEA_RUINS
end

return zoneObject
