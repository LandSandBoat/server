-----------------------------------
-- Zone: Dangruf_Wadi (191)
-----------------------------------
local ID = zones[xi.zone.DANGRUF_WADI]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCuboidTriggerArea(1, -133.5, 2, 132.6, -132.7, 4,  133.8)  -- I-8 Geyser
    zone:registerCuboidTriggerArea(2, -213.5, 2,  92.6, -212.7, 4,   94.0)  -- H-8 Geyser
    zone:registerCuboidTriggerArea(3,  -67.3, 2, 532.8,  -66.3, 4,  534.0)  -- J-3 Geyser

    xi.treasure.initZone(zone)
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
        player:setPos(-4.025, -4.449, 0.016, 112)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    switch (triggerArea:getTriggerAreaID()): caseof
    {
        [1] = function()
            player:startEvent(10)
            SendEntityVisualPacket(ID.npc.GEYSER_OFFSET, 'kkj2')
        end,

        [2] = function()
            player:startEvent(11)
            SendEntityVisualPacket(ID.npc.GEYSER_OFFSET + 1, 'kkj1')
        end,

        [3] = function()
            player:startEvent(12)
            SendEntityVisualPacket(ID.npc.GEYSER_OFFSET + 2, 'kkj3')
        end,
    }
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

zoneObject.onGameHour = function(zone)
    local nm = GetMobByID(ID.mob.GEYSER_LIZARD)
    if not nm then
        return
    end

    local pop = nm:getLocalVar('pop')

    if
        os.time() > pop and
        not nm:isSpawned()
    then
        UpdateNMSpawnPoint(ID.mob.GEYSER_LIZARD)
        nm:spawn()
    end
end

zoneObject.onZoneWeatherChange = function(weather)
    if
        weather == xi.weather.NONE or
        weather == xi.weather.SUNSHINE
    then
        GetNPCByID(ID.npc.AN_EMPTY_VESSEL_QM):setStatus(xi.status.NORMAL)
    else
        GetNPCByID(ID.npc.AN_EMPTY_VESSEL_QM):setStatus(xi.status.DISAPPEAR)
    end
end

return zoneObject
