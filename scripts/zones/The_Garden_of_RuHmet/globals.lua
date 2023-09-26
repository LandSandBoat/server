-- Zone: The_Garden_of_RuHmet (35)
-----------------------------------
local ID = zones[xi.zone.THE_GARDEN_OF_RUHMET]
-----------------------------------

local moveJailerOfFaithQM
moveJailerOfFaithQM = function(qmFaith, respawnDelay)
    local timersRunning = qmFaith:getLocalVar('timersRunning')
    local shouldMove = true

    -- If respawnDelay is not set, this is a timer callback. An extra timer may be
    -- running if JoF is spawned and killed before the previous timer triggers
    if respawnDelay == nil then
        timersRunning = timersRunning - 1
        -- Only move the QM if the QM is not hidden and there's no other timers running
        shouldMove = qmFaith:getStatus() ~= xi.status.DISAPPEAR and timersRunning == 0
    end

    if shouldMove then
        -- Move to a random predefined position
        qmFaith:setPos(unpack(ID.npc.QM_JAILER_OF_FAITH_POS[math.random(1, 5)]))

        -- Base delay before next move is 30 minutes
        local delay = utils.minutes(30)

        if respawnDelay ~= nil then
            -- If this was triggered from a JoF despawn, add the QM respawn time to the delay
            delay = delay + respawnDelay
        else
            -- For a regular move, hide the QM for 60s and add that to the delay
            qmFaith:hideNPC(60)
            delay = delay + 60
        end

        timersRunning = timersRunning + 1
        qmFaith:timer(delay * 1000, moveJailerOfFaithQM)
    end

    qmFaith:setLocalVar('timersRunning', timersRunning)
end

local ruhmetGlobal = {}
ruhmetGlobal.moveJailerOfFaithQM = moveJailerOfFaithQM
return ruhmetGlobal
