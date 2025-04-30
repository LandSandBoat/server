-----------------------------------
-- Waking the Colossus/Divine Interference
-- !instance 7702
-----------------------------------
local ID = zones[xi.zone.NYZUL_ISLE]
-----------------------------------
local instanceObject = {}

instanceObject.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.LIGHTNING_CELL) and
        xi.quest.getVar(player, xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.DIVINE_INTERFERENCE, 'Prog') >= 3
end

instanceObject.entryRequirements = function(player)
    return player:hasKeyItem(xi.ki.LIGHTNING_CELL) and
        xi.quest.getVar(player, xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.DIVINE_INTERFERENCE, 'Prog') >= 3
end

instanceObject.onInstanceCreated = function(instance)
    SpawnMob(ID.mob.ALEXANDER_WTC, instance)
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

    player:delKeyItem(xi.ki.LIGHTNING_CELL)
    player:messageSpecial(ID.text.LIGHTNING_CELL_SPARKS, xi.ki.LIGHTNING_CELL)
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instanceObject.onInstanceFailure = function(instance)
    local chars = instance:getChars()

    for _, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(1)
    end
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
    if progress == 1 then
        instance:complete()
    end
end

instanceObject.onInstanceComplete = function(instance)
    local chars = instance:getChars()

    for _, v in pairs(chars) do
        v:startEvent(1)
        xi.quest.setVar(v, xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.DIVINE_INTERFERENCE, 'Prog', 4)
    end
end

instanceObject.onEventFinish = function(player, csid, option, npc)
    local instance = player:getInstance()
    local chars = instance:getChars()

    if csid == 1 then
        for _, v in pairs(chars) do
            v:setPos(180, -0.05, 20, 0, xi.zone.ALZADAAL_UNDERSEA_RUINS)
        end
    end
end

return instanceObject
