-----------------------------------
-- Zone: Bhaflau_Remnants
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCylindricalTriggerArea(1, 340, -420, 4)
    zone:registerCylindricalTriggerArea(2, 260, 300, 4)
    zone:registerCylindricalTriggerArea(3, 300, 60, 4)
    zone:registerCylindricalTriggerArea(4, 420, 300, 4)
    zone:registerCylindricalTriggerArea(5, 380, 60, 4)
    zone:registerCylindricalTriggerArea(6, -460, -500, 4)
    zone:registerCylindricalTriggerArea(7, -220, -500, 4)
    zone:registerCylindricalTriggerArea(8, -340, 60, 4)
    zone:registerCylindricalTriggerArea(9, -380, 380, 4)
    zone:registerCylindricalTriggerArea(10, -300, 380, 4)
end

zoneObject.onInstanceZoneIn = function(player, instance)
    if player:getInstance() == nil then
        player:setPos(620, 0, -260.640, 72, 72)
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
