-----------------------------------
--
-- Assault: Seagull Grounded
--
-----------------------------------
local ID = require("scripts/zones/Periqia/IDs")
-----------------------------------

function afterInstanceRegister(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.ASSAULT_31_START, 1)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

function onInstanceCreated(instance)

    for i, v in pairs(ID.mob[31]) do
        SpawnMob(v, instance)
    end

    local rune = instance:getEntity(bit.band(ID.npc.RUNE_OF_RELEASE, 0xFFF), tpz.objType.NPC)
    local box = instance:getEntity(bit.band(ID.npc.ANCIENT_LOCKBOX, 0xFFF), tpz.objType.NPC)
    rune:setPos(-495, -9.899, -72, 0)
    box:setPos(-495, -9.695, -75, 0)

    instance:getEntity(bit.band(ID.npc.EXCALIACE, 0xFFF), tpz.objType.NPC):setStatus(1)
    instance:getEntity(bit.band(ID.npc._1K6, 0xFFF), tpz.objType.NPC):setAnimation(8)
    instance:getEntity(bit.band(ID.npc._1KX, 0xFFF), tpz.objType.NPC):setAnimation(8)
    instance:getEntity(bit.band(ID.npc._1KZ, 0xFFF), tpz.objType.NPC):setAnimation(8)
    instance:getEntity(bit.band(ID.npc._JK1, 0xFFF), tpz.objType.NPC):setAnimation(8)
    instance:getEntity(bit.band(ID.npc._JK3, 0xFFF), tpz.objType.NPC):setAnimation(8)

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
            if (remainingTimeLimit >= 60) then
                v:messageSpecial(ID.text.TIME_REMAINING_MINUTES, remainingTimeLimit / 60)
            else
                v:messageSpecial(ID.text.TIME_REMAINING_SECONDS, remainingTimeLimit)
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

    if (progress > 0) then
        instance:complete()
    end

end

function onInstanceComplete(instance)

    local chars = instance:getChars()

    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.RUNE_UNLOCKED_POS, 8, 8)
    end

    local rune = instance:getEntity(bit.band(ID.npc.RUNE_OF_RELEASE, 0xFFF), tpz.objType.NPC)
    local box = instance:getEntity(bit.band(ID.npc.ANCIENT_LOCKBOX, 0xFFF), tpz.objType.NPC)
    rune:setStatus(tpz.status.NORMAL)
    box:setStatus(tpz.status.NORMAL)

end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
