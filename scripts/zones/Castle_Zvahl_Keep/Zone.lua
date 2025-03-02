-----------------------------------
-- Zone: Castle_Zvahl_Keep (162)
-----------------------------------
local ID = zones[xi.zone.CASTLE_ZVAHL_KEEP]
-----------------------------------
---@type TZone
local zoneObject = {}

local teleportTable =
{
    [1] = { npc = ID.npc.TELE_CENTER, event = 0, }, -- Teleports player to far NE corner
    [2] = { npc = ID.npc.TELE_NE,     event = 2, }, -- Teleports player to far SE corner
    [3] = { npc = ID.npc.TELE_SE,     event = 3, }, -- Teleports player to far SW corner (from middle-SE porter)
    [4] = { npc = ID.npc.TELE_NW,     event = 1, }, -- Teleports player to far SW corner (from middle-NW porter)
    [5] = { npc = ID.npc.TELE_SW,     event = 4, }, -- Teleports player to the top of the stairs on map 4
    [6] = { npc = ID.npc.TELE_N,      event = 6, }, -- Teleports player to position to one of several random positions
    [7] = { npc = ID.npc.TELE_S,      event = 7, }, -- Teleports player to position to one of several random positions
    [8] = { npc = ID.npc.TELE_HIDDEN, event = 5, }, -- Teleports player to H-7 on map 4 platform near the ore door (south or north part randomly)
}

zoneObject.onInitialize = function(zone)
    zone:registerCylindricalTriggerArea(1, -300, -20, 3) -- central porter on map 3
    zone:registerCylindricalTriggerArea(2, -273, 5, 3) -- NE porter on map 3
    zone:registerCylindricalTriggerArea(3, -273, -45, 3) -- SE porter on map 3
    zone:registerCylindricalTriggerArea(4, -327, 5, 3) -- NW porter on map 3
    zone:registerCylindricalTriggerArea(5, -327, -45, 3) -- SW porter on map 3
    zone:registerCylindricalTriggerArea(6, -527, 87, 3) -- N porter on map 4
    zone:registerCylindricalTriggerArea(7, -527, 33, 3) -- S porter on map 4
    zone:registerCylindricalTriggerArea(8, -460, 60, 3) -- Hidden room porter on map 4

    xi.treasure.initZone(zone)
end

zoneObject.onZoneTick = function(zone)
    -- Cycle opening Teleporters every 20-60 seconds on individual timers
    for _, table in pairs(teleportTable) do
        local teleporter = GetNPCByID(table.npc)

        if teleporter and teleporter:getLocalVar('timer') < os.time() then
            -- If a player is already on the pad, teleport them
            for _, player in pairs(zone:getPlayers()) do
                if player:getLocalVar(string.format('Zvhal_teleporter_%s', table.npc)) == 1 then
                    player:startCutscene(table.event)
                end
            end

            teleporter:openDoor(8)
            teleporter:setLocalVar('timer', math.random(15, 60) + os.time())
        end
    end
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-555.996, -71.691, 59.989, 254)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local table      = teleportTable[triggerArea:getTriggerAreaID()]
    local teleporter = GetNPCByID(table.npc)

    player:setLocalVar(string.format('Zvhal_teleporter_%s', table.npc), 1)

    if teleporter and teleporter:getAnimation() == xi.animation.OPEN_DOOR then
        player:startCutscene(table.event)
    end
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
    local table = teleportTable[triggerArea:getTriggerAreaID()]

    player:setLocalVar(string.format('Zvhal_teleporter_%s', table.npc), 0)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
