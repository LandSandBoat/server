-----------------------------------
-- Instance
-----------------------------------
tpz = tpz or {}
tpz.instance = {}

local function setInstanceLastTimeUpdateMessage(instance, players, remainingTimeLimit)
    local message = 0
    local lastTimeUpdate = instance:getLastTimeUpdate()

    if lastTimeUpdate == 0 and remainingTimeLimit < 600 then
        message = 600
    elseif lastTimeUpdate == 600 and remainingTimeLimit < 300 then
        message = 300
    elseif lastTimeUpdate == 300 and remainingTimeLimit < 60 then
        message = 60
    elseif lastTimeUpdate == 60 and remainingTimeLimit < 30 then
        message = 30
    elseif lastTimeUpdate == 30 and remainingTimeLimit < 10 then
        message = 10
    end

    if message ~= 0 then
        for i, player in pairs(players) do
            if remainingTimeLimit >= 60 then
                player:messageSpecial(texttable.TIME_REMAINING_MINUTES, remainingTimeLimit / 60)
            else
                player:messageSpecial(texttable.TIME_REMAINING_SECONDS, remainingTimeLimit)
            end
        end
        instance:setLastTimeUpdate(message)
    end
end

tpz.instance.updateInstanceTime = function(instance, elapsed, texttable)
    local players = instance:getChars()
    local remainingTimeLimit = (instance:getTimeLimit()) * 60 - (elapsed / 1000)
    local wipeTime = instance:getWipeTime()

    if remainingTimeLimit < 0 or (wipeTime ~= 0 and (elapsed - wipeTime) / 1000 > 180) then
        instance:fail()
        return
    end

    if wipeTime == 0 then
        local wipe = true
        for i, player in pairs(players) do
            if player:getHP() ~= 0 then
                wipe = false
                break
            end
        end
        if wipe then
            for i, player in pairs(players) do
                player:messageSpecial(texttable.PARTY_FALLEN, 3)
            end
            instance:setWipeTime(elapsed)
        end
    else
        for i, player in pairs(players) do
            if player:getHP() ~= 0 then
                instance:setWipeTime(0)
                break
            end
        end
    end
    setInstanceLastTimeUpdateMessage(instance, players, remainingTimeLimit)
end
