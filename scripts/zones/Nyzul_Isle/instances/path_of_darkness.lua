-----------------------------------
--
-- TOAU-42: Path of Darkness
--
-----------------------------------
local ID = require("scripts/zones/Nyzul_Isle/IDs")
require("scripts/globals/instance")
require("scripts/globals/keyitems")
-----------------------------------

function afterInstanceRegister(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

function onInstanceCreated(instance)
    SpawnMob(ID.mob[58].AMNAF_BLU, instance)
    SpawnMob(ID.mob[58].NAJA, instance)
end

function onInstanceTimeUpdate(instance, elapsed)
    updateInstanceTime(instance, elapsed, ID.text)
end

function onInstanceFailure(instance)
    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(1)
    end
end

function onInstanceProgressUpdate(instance, progress)
    if(progress >= 10 and progress < 20) then
        DespawnMob(ID.mob[58].AMNAF_BLU, instance)
    elseif(progress == 24) then
        local v = instance:getEntity(bit.band(ID.mob[58].NAJA, 0xFFF), tpz.objType.MOB)
        v:setLocalVar("ready", 0)
        v:setLocalVar("Stage", 2)

        SpawnMob(ID.mob[58].AMNAF_BLU, instance)
    elseif(progress >= 30 and progress < 40) then
        DespawnMob(ID.mob[58].AMNAF_BLU, instance)
    elseif(progress == 48) then
        SpawnMob(ID.mob[58].AMNAF_PSYCHEFLAYER, instance)

        local v = instance:getEntity(bit.band(ID.mob[58].NAJA, 0xFFF), tpz.objType.MOB)
        v:setLocalVar("ready", 0)
        v:setLocalVar("Stage", 3)

        local npcs = instance:getNpcs()

        for i, v in pairs(npcs) do
            if(v:getID() == ID.npc._259) then
                v:setAnimation(8)
            end
        end
    elseif(progress == 50) then
        instance:complete()
    end
end

function onInstanceComplete(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        if (v:getCurrentMission(TOAU) == tpz.mission.id.toau.PATH_OF_DARKNESS and v:getCharVar("AhtUrganStatus") == 1) then
            v:setCharVar("AhtUrganStatus", 2)
        end

        v:setPos(0, 0, 0, 0, 72)
    end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
