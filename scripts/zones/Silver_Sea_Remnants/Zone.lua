-----------------------------------
-- Zone: Silver_Sea_Remnants
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, 305.5, -1, -414.5, 374.5, 1, -345.5) -- Special Fomor room
    zone:registerCylindricalTriggerArea(2, 340, -300, 4)
    zone:registerCylindricalTriggerArea(3, 260, 380, 4)
    zone:registerCylindricalTriggerArea(4, 300, 620, 4)
    zone:registerCylindricalTriggerArea(5, 420, 380, 4)
    zone:registerCylindricalTriggerArea(6, 380, 620, 4)
    zone:registerCylindricalTriggerArea(7, -460, -300, 4)
    zone:registerCylindricalTriggerArea(8, -220, -300, 4)
    zone:registerCylindricalTriggerArea(9, -340, 100, 4)
    zone:registerCylindricalTriggerArea(10, -300, 620, 4)
    zone:registerCylindricalTriggerArea(11, -380, 620, 4)
end

zoneObject.onInstanceZoneIn = function(player, instance)
    if player:getInstance() == nil then
        player:setPos(580, 0, 500, 192, 72)
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
