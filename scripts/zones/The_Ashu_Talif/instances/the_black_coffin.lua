-----------------------------------
-- TOAU-15: The Black Coffin
-- !instance 6000
-----------------------------------
local ID = zones[xi.zone.THE_ASHU_TALIF]
-----------------------------------
local instanceObject = {}

instanceObject.registryRequirements = function(player)
    return player:getCurrentMission(xi.mission.log_id.TOAU) == xi.mission.id.toau.THE_BLACK_COFFIN and
        player:hasKeyItem(xi.ki.EPHRAMADIAN_GOLD_COIN)
end

instanceObject.entryRequirements = function(player)
    return player:getCurrentMission(xi.mission.log_id.TOAU) >= xi.mission.id.toau.THE_BLACK_COFFIN and
        player:hasKeyItem(xi.ki.EPHRAMADIAN_GOLD_COIN)
end

instanceObject.onInstanceCreated = function(instance)
    SpawnMob(ID.mob.GESSHO, instance)
    for i, mob in pairs(ID.mob[1]) do
        SpawnMob(mob, instance)
    end
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instanceObject.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.FADES_INTO_NOTHINGNESS, xi.ki.EPHRAMADIAN_GOLD_COIN)
    player:delKeyItem(xi.ki.EPHRAMADIAN_GOLD_COIN)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instanceObject.onInstanceFailure = function(instance)
    local chars = instance:getChars()

    for i, char in pairs(chars) do
        char:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        char:startEvent(102)
    end
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
    if progress == 5 then
        for i, mob in pairs(ID.mob[2]) do
            SpawnMob(mob, instance)
        end
    elseif progress >= 10 and not instance:completed() then
        local ally = GetMobByID(ID.mob.GESSHO, instance)
        if ally:isAlive() then
            ally:setLocalVar('ready', 2)
        end

        instance:complete()
    end
end

instanceObject.onInstanceComplete = function(instance)
    local players = instance:getChars()

    DespawnMob(ID.mob.GESSHO, instance)
    for i, mob in pairs(ID.mob[2]) do
        DespawnMob(mob, instance)
    end

    for i, player in pairs(players) do
        if
            player:getCurrentMission(xi.mission.log_id.TOAU) == xi.mission.id.toau.THE_BLACK_COFFIN and
            player:getMissionStatus(xi.mission.log_id.TOAU) == 1
        then
            player:setMissionStatus(xi.mission.log_id.TOAU, 2)
        end

        player:startEvent(102)
    end
end

return instanceObject
