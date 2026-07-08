-----------------------------------
-- Mission class
-----------------------------------
require('scripts/globals/interaction/container')
-----------------------------------
---@see TInteractionContainer
---@class TMission : TInteractionContainer
---@field areaId integer
---@field missionId integer
Mission = setmetatable({ areaId = -1 }, { __index = Container })
Mission.__index = Mission

Mission.__eq = function(m1, m2)
    return m1.areaId == m2.areaId and m1.missionId == m2.missionId
end

---@type rewardParam
Mission.reward = {}

---@type TMissionSection[]
Mission.sections = {}

---@nodiscard
---@param areaId integer
---@param missionId integer
---@return TMission
function Mission:new(areaId, missionId)
    local obj = Container:new(Mission.getVarPrefix(areaId, missionId))
    setmetatable(obj, self)
    obj.areaId = areaId
    obj.missionId = missionId
    return obj
end

---@nodiscard
---@param areaId integer
---@param missionId integer
---@return string
function Mission.getVarPrefix(areaId, missionId)
    return string.format('Mission[%d][%d]', areaId, missionId)
end

---@nodiscard
---@param player CBaseEntity
---@return table<integer>
function Mission:getCheckArgs(player)
    return { player:getCurrentMission(self.areaId), player:getMissionStatus(self.areaId) }
end

-----------------------------------
-- Mission operations
-----------------------------------

---@param player CBaseEntity
---@return nil
function Mission:begin(player)
    player:addMission(self.areaId, self.missionId)
end

---@param player CBaseEntity
---@return boolean
function Mission:complete(player)
    local didComplete = npcUtil.completeMission(player, self.areaId, self.missionId, self.reward)
    if didComplete then
        -- We do not want to reset values for CoP Missions
        if self.areaId ~= 6 then
            player:setMissionStatus(self.areaId, 0)
        end

        self:cleanup(player)
    end

    return didComplete
end
