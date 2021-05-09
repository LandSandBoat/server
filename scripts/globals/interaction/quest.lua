-----------------------------------
-- Quest class
-----------------------------------
require('scripts/globals/interaction/container')
-----------------------------------

Quest = setmetatable({ areaId = -1 }, { __index = Container })
Quest.__index = Quest
Quest.__eq = function(q1, q2)
    return q1.areaId == q2.areaId and q1.questId == q2.questId
end

Quest.reward = {}

function Quest:new(areaId, questId)
    local obj = Container:new(Quest.getVarPrefix(areaId, questId))
    setmetatable(obj, self)
    obj.areaId = areaId
    obj.questId = questId
    return obj
end

function Quest.getVarPrefix(areaId, questId)
    return string.format("Quest[%d][%d]", areaId, questId)
end

function Quest:getCheckArgs(player)
    return { player:getQuestStatus(self.areaId, self.questId) }
end

-----------------------------------
-- Quest operations
-----------------------------------

function Quest:begin(player)
    player:addQuest(self.areaId, self.questId)
end

function Quest:complete(player)
    local didComplete = npcUtil.completeQuest(player, self.areaId, self.questId, self.reward)
    if didComplete then
        self:cleanup(player)
    end
    return didComplete
end
