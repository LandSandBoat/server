-- COR AF3: Against All Odds
-- !instance 6001
-----------------------------------
local ID = zones[xi.zone.THE_ASHU_TALIF]
-----------------------------------
local instanceObject = {}

local mobTable =
{
    ID.mob.GOWAM,
    ID.mob.YAZQUHL,
}

instanceObject.registryRequirements = function(player)
    return player:hasKeyItem(xi.ki.LIFE_FLOAT) and
        player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.AGAINST_ALL_ODDS) == xi.questStatus.QUEST_ACCEPTED and
        xi.quest.getVar(player, xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.AGAINST_ALL_ODDS, 'Prog') == 1
end

instanceObject.entryRequirements = function(player)
    return true -- TODO
end

instanceObject.onInstanceCreated = function(instance)
    for i, v in pairs(mobTable) do
        SpawnMob(v, instance)
    end
end

instanceObject.onInstanceCreatedCallback = function(player, instance)
    xi.instance.onInstanceCreatedCallback(player, instance)
end

instanceObject.afterInstanceRegister = function(player)
    local instance = player:getInstance()
    player:messageSpecial(ID.text.FADES_INTO_NOTHINGNESS, xi.ki.LIFE_FLOAT)
    player:delKeyItem(xi.ki.LIFE_FLOAT)
    player:messageSpecial(ID.text.TIME_TO_COMPLETE, instance:getTimeLimit())
end

instanceObject.onInstanceTimeUpdate = function(instance, elapsed)
    xi.instance.updateInstanceTime(instance, elapsed, ID.text)
end

instanceObject.onInstanceFailure = function(instance)
    local chars = instance:getChars()
    for i, v in pairs(chars) do
        v:messageSpecial(ID.text.MISSION_FAILED, 10, 10)
        v:startEvent(102)
    end
end

instanceObject.onInstanceProgressUpdate = function(instance, progress)
    if progress == 2 then
        instance:complete()
    end
end

instanceObject.onInstanceComplete = function(instance)
    local chars = instance:getChars()
    for i, v in pairs(chars) do
        if
            v:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.AGAINST_ALL_ODDS) == xi.questStatus.QUEST_ACCEPTED and
            xi.quest.getVar(v, xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.AGAINST_ALL_ODDS, 'Prog') == 1
        then
            xi.quest.setVar(v, xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.AGAINST_ALL_ODDS, 'Prog', 2)
            xi.quest.setVar(v, xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.AGAINST_ALL_ODDS, 'Wait', 0)
        end

        v:startEvent(102)
    end
end

return instanceObject
