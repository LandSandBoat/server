-----------------------------------
-- TOAU-15: The Black Coffin
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
local instance_helpers = require("scripts/globals/instance")
-----------------------------------
local instance_object = {}

instance_object.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.FADES_INTO_NOTHINGNESS, tpz.ki.EPHRAMADIAN_GOLD_COIN)
    player:delKeyItem(tpz.ki.EPHRAMADIAN_GOLD_COIN)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

instance_object.onInstanceCreated = function(instance)
    SpawnMob(ID.mob.GESSHO, instance)
    for i, mob in pairs(ID.mob[1]) do
        SpawnMob(mob, instance)
    end
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    instance_helpers.updateInstanceTime(instance, elapsed, ID.text)
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

    for i, player in pairs(players) do
        if player:getCurrentMission(TOAU) == tpz.mission.id.toau.THE_BLACK_COFFIN and player:getCharVar("AhtUrganStatus") == 1 then
            player:setCharVar("AhtUrganStatus", 2)
        end
        player:startEvent(102)
    end
end

instance_object.onEventUpdate = function (player, csid, option)
end

instance_object.onEventFinish = function (player, csid, option)
    if csid == 102 then
        player:setPos(0, 0, 0, 0, 54)
    end
end

return instance_object
