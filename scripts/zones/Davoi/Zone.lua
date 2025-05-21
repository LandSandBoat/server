-----------------------------------
-- Zone: Davoi (149)
-----------------------------------
local ID = zones[xi.zone.DAVOI]
require('scripts/quests/otherAreas/helpers')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.treasure.initZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(218, 0, -5, 66)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onGameDay = function()
    -- move storage hole
    local positions =
    {
        { -177.925,  4.000, -255.699 },
        { -127.703,  4.250,   23.732 },
        { -127.822,  4.250,  -16.964 },
        { -123.369,  4.000, -231.972 },
        {  -51.570,  4.127, -216.462 },
        {  -55.960,  2.958, -300.014 },
        {  152.311,  4.000,  -74.176 },
        {  153.514,  4.250, -112.616 },
        {  188.988,  4.000,  -80.058 },
        {  318.694,  0.001,  -58.646 },
        {  299.717,  0.001, -160.910 },
        {  274.849,  4.162, -213.599 },
        {  250.809,  4.000, -240.509 },
        {  219.474,  3.750, -128.170 },
        {   86.749, -5.166, -166.414 },
    }
    local newPosition = npcUtil.pickNewPosition(ID.npc.STORAGE_HOLE, positions)
    GetNPCByID(ID.npc.STORAGE_HOLE):setPos(newPosition.x, newPosition.y, newPosition.z)
end

zoneObject.onGameHour = function(zone)
    local jarMoveTime = GetServerVariable('Davoi_Jar_Move_Time')

    if os.time() >= jarMoveTime then
        local npc = GetNPCByID(ID.npc.JAR)

        xi.otherAreas.helpers.TestMyMettle.moveJar(npc)
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
