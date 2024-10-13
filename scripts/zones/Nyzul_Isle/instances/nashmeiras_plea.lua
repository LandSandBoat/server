-----------------------------------
-- TOAU-44: Nashmeira's Plea
-- !instance 7701
-----------------------------------
local ID = zones[xi.zone.NYZUL_ISLE]
-----------------------------------
local instanceObject = {}

instanceObject.entitiesToBeLoaded = {
    ID.mob[59].RAZFAHD,
    ID.mob[59].ALEXANDER,
    ID.mob[59].RAUBAHN,

    ID.npc.WEATHER,
    ID.npc.QM1,
    ID.npc.BLANK1,
    ID.npc.BLANK2,
    ID.npc.BLANK3,
    ID.npc.NASHMEIRA1,
    ID.npc.NASHMEIRA2,
    ID.npc.RAZFAHD,
    ID.npc.CSNPC1,
    ID.npc.GHATSAD,
    ID.npc.ALEXANDER,
    ID.npc.CSNPC2,
}

instanceObject.registryRequirements = function(player)
    return player:getCurrentMission(xi.mission.log_id.TOAU) == xi.mission.id.toau.NASHMEIRAS_PLEA and
        player:hasKeyItem(xi.ki.MYTHRIL_MIRROR) and
        player:getMissionStatus(xi.mission.log_id.TOAU) == 1
end

instanceObject.entryRequirements = function(player)
    return player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.NASHMEIRAS_PLEA
end

instanceObject.onInstanceCreated = function(instance)
    SpawnMob(ID.mob[59].RAUBAHN, instance)
    SpawnMob(ID.mob[59].RAZFAHD, instance)
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)

    -- Kill the Nyzul Isle update spam
    for _, v in ipairs(player:getParty()) do
        if v:getZoneID() == instance:getEntranceZoneID() then
            v:updateEvent(405, 3, 3, 3, 3, 3, 3, 3)
        end
    end
end

instanceObject.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())

    player:delKeyItem(xi.ki.MYTHRIL_MIRROR)
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instanceObject.onInstanceFailure = function(instance)
    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(1)
    end
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
    if progress == 4 then
        local chars = instance:getChars()
        local entryPos = instance:getEntryPos()

        DespawnMob(ID.mob[59].RAUBAHN, instance)
        DespawnMob(ID.mob[59].RAZFAHD, instance)
        for i, v in pairs(chars) do
            v:startEvent(203)
            v:setPos(entryPos.x, entryPos.y, entryPos.z, entryPos.rot)
        end

        SpawnMob(ID.mob[59].ALEXANDER, instance)

    elseif progress == 5 then
        instance:complete()
    end
end

instanceObject.onInstanceComplete = function(instance)
    local chars = instance:getChars()

    for i, v in pairs(chars) do
        if
            v:getCurrentMission(xi.mission.log_id.TOAU) == xi.mission.id.toau.NASHMEIRAS_PLEA and
            v:getMissionStatus(xi.mission.log_id.TOAU) == 1
        then
            v:setMissionStatus(xi.mission.log_id.TOAU, 2)
        end

        v:setPos(0, 0, 0, 0, 72)
    end
end

instanceObject.onEventFinish = function(player, csid, option, npc)
end

return instanceObject
