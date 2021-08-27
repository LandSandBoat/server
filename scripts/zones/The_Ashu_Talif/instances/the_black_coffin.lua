-----------------------------------
-- TOAU-15: The Black Coffin
-- !instance 6000
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
-----------------------------------
local instance_object = {}

instance_object.registryRequirements = function(player)
    return player:getCurrentMission(TOAU) == xi.mission.id.toau.THE_BLACK_COFFIN and
           player:hasKeyItem(xi.ki.EPHRAMADIAN_GOLD_COIN)
end

instance_object.entryRequirements = function(player)
    return player:getCurrentMission(TOAU) >= xi.mission.id.toau.THE_BLACK_COFFIN and
           player:hasKeyItem(xi.ki.EPHRAMADIAN_GOLD_COIN)
end

instance_object.onInstanceCreated = function(instance)
    SpawnMob(ID.mob.GESSHO, instance)
    for i, mob in pairs(ID.mob[1]) do
        SpawnMob(mob, instance)
    end
end

instance_object.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instance_object.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.FADES_INTO_NOTHINGNESS, xi.ki.EPHRAMADIAN_GOLD_COIN)
    player:delKeyItem(xi.ki.EPHRAMADIAN_GOLD_COIN)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instance_object.onInstanceFailure = function(instance)
    local chars = instance:getChars()

    for i, char in pairs(chars) do
        char:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        char:startEvent(102)
    end
end

instance_object.onInstanceProgressUpdate = function(instance, progress)
    if progress == 5 then
        for i, mob in pairs(ID.mob[2]) do
            SpawnMob(mob, instance)
        end
    elseif progress >= 10 and instance:completed() == false then
        local ally = GetMobByID(ID.mob.GESSHO, instance)
        if ally:isAlive() then
            ally:setLocalVar("ready", 2)
        end
        instance:complete()
    end

end

instance_object.onInstanceComplete = function(instance)
    local players = instance:getChars()

    DespawnMob(ID.mob.GESSHO, instance)
    for i, mob in pairs(ID.mob[2]) do
        DespawnMob(mob, instance)
    end

    for i, player in pairs(players) do
        if player:getCurrentMission(TOAU) == xi.mission.id.toau.THE_BLACK_COFFIN and player:getCharVar("AhtUrganStatus") == 1 then
            player:setCharVar("AhtUrganStatus", 2)
        end
        player:startEvent(102)
    end
end

return instance_object
