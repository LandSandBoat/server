-----------------------------------
-- Quest class
-----------------------------------
require('scripts/globals/interaction/container')
-----------------------------------
---@see TInteractionContainer
---@class TQuest : TInteractionContainer
---@field areaId xi.questLog
---@field questId integer
Quest = setmetatable({ areaId = 0 }, { __index = Container })
Quest.__index = Quest

---@diagnostic disable-next-line: duplicate-set-field
Quest.__eq = function(q1, q2)
    return q1.areaId == q2.areaId and q1.questId == q2.questId
end

---@type rewardParam
Quest.reward = {}

---@type TQuestSectionList
Quest.sections = {}

---@param areaId xi.questLog
---@param questId integer
---@return TQuest
function Quest:new(areaId, questId)
    local obj = Container:new(Quest.getVarPrefix(areaId, questId))
    setmetatable(obj, self)
    obj.areaId = areaId
    obj.questId = questId
    return obj
end

---@param areaId xi.questLog
---@param questId integer
---@return string
function Quest.getVarPrefix(areaId, questId)
    return string.format('Quest[%d][%d]', areaId, questId)
end

---@param player CBaseEntity
---@return { [integer]: xi.questStatus }
function Quest:getCheckArgs(player)
    return { player:getQuestStatus(self.areaId, self.questId) }
end

-----------------------------------
-- Quest operations
-----------------------------------

---@param player CBaseEntity
---@return nil
function Quest:begin(player)
    player:addQuest(self.areaId, self.questId)
end

---@param player CBaseEntity
---@return boolean
function Quest:complete(player)
    local didComplete = npcUtil.completeQuest(player, self.areaId, self.questId, self.reward)
    if didComplete then
        self:cleanup(player)
    end

    return didComplete
end
