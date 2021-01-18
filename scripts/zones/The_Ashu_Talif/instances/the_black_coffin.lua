-----------------------------------
-- TOAU-15: The Black Coffin
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/keyitems")
local ID = require("scripts/zones/The_Ashu_Talif/IDs")
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
    for i, v in pairs(ID.mob[1]) do
        SpawnMob(v, instance)
    end
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    updateInstanceTime(instance, elapsed, ID.text)
end

instance_object.onInstanceFailure = function(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(102)
    end
end

instance_object.onInstanceProgressUpdate = function(instance, progress)

    if (progress == 5) then
        for i, v in pairs(ID.mob[2]) do
            SpawnMob(v, instance)
        end
    elseif (progress >= 10 and instance:completed() == false) then
        local v = GetMobByID(ID.mob.GESSHO, instance)

        if(v:isAlive()) then
            v:setLocalVar("ready", 2)
        end

        local chars = instance:getChars()

        for i, v in pairs(chars) do
            v:startEvent(102)
        end

        instance:complete()
    end

end

instance_object.onInstanceComplete = function(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        if (v:getCurrentMission(TOAU) == tpz.mission.id.toau.THE_BLACK_COFFIN and v:getCharVar("AhtUrganStatus") == 1) then
            v:setCharVar("AhtUrganStatus", 2)
            v:startEvent(101)
        else
            v:startEvent(102)
        end
    end
end

instance_object.onEventUpdate = function(player, csid, option)
end

instance_object.onEventFinish = function(player, csid, option)
end

return instance_object
