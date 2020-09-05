-----------------------------------
--
-- Assault: Wamoura Farm Raid
--
-----------------------------------
local ID = require("scripts/zones/Lebros_Cavern/IDs")
-----------------------------------

function afterInstanceRegister(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.ASSAULT_27_START, 27)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

function onInstanceCreated(instance)

    for i, v in pairs(ID.mob[27]) do
        SpawnMob(v, instance)
    end

end

function onInstanceTimeUpdate(instance, elapsed)
    local players = instance:getChars()
    local lastTimeUpdate = instance:getLastTimeUpdate()
    local remainingTimeLimit = (instance:getTimeLimit()) * 60 - (elapsed / 1000)
    local wipeTime = instance:getWipeTime()
    local message = 0

    if (remainingTimeLimit < 0) then
        instance:fail()
        return
    end

    if (wipeTime == 0) then
        local wipe = true
        for i, v in pairs(players) do
            if v:getHP() ~= 0 then
                wipe = false
                break
            end
        end
        if (wipe) then
            for i, v in pairs(players) do
                v:messageSpecial(ID.text.PARTY_FALLEN, 3)
            end
            instance:setWipeTime(elapsed)
        end
    else
        if (elapsed - wipeTime) / 1000 > 180 then
            instance:fail()
            return
        else
            for i, v in pairs(players) do
                if v:getHP() ~= 0 then
                    instance:setWipeTime(0)
                    break
                end
            end
        end
    end

    if (lastTimeUpdate == 0 and elapsed > 20 * 60000) then
        message = 600
    elseif (lastTimeUpdate == 600 and remainingTimeLimit < 300) then
        message = 300
    elseif (lastTimeUpdate == 300 and remainingTimeLimit < 60) then
        message = 60
    elseif (lastTimeUpdate == 60 and remainingTimeLimit < 30) then
        message = 30
    elseif (lastTimeUpdate == 30 and remainingTimeLimit < 10) then
        message = 10
    end

    if (message ~= 0) then
        for i, v in pairs(players) do
            if (timeRemaining >= 60) then
                v:messageSpecial(ID.text.TIME_REMAINING_MINUTES, timeRemaining / 60)
            else
                v:messageSpecial(ID.text.TIME_REMAINING_SECONDS, timeRemaining)
            end
        end
        instance:setLastTimeUpdate(message)
    end
end

function onInstanceFailure(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(102)
    end
end

function onInstanceProgressUpdate(instance, progress)

    if (progress >= 15) then
        instance:complete()
    end

end

function onInstanceComplete(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.RUNE_UNLOCKED, 7, 8)
    end

    local rune = instance:getEntity(bit.band(ID.npc.RUNE_OF_RELEASE, 0xFFF), tpz.objType.NPC)
    local box = instance:getEntity(bit.band(ID.npc.ANCIENT_LOCKBOX, 0xFFF), tpz.objType.NPC)
    rune:setPos(414.29, -40.64, 301.523, 247)
    rune:setStatus(tpz.status.NORMAL)
    box:setPos(410.41, -41.12, 300.743, 243)
    box:setStatus(tpz.status.NORMAL)

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
