-----------------------------------
-- Mission class
-----------------------------------
require('scripts/globals/interaction/container')
-----------------------------------

Mission = setmetatable({ areaId = -1 }, { __index = Container })
Mission.__index = Mission
Mission.__eq = function(m1, m2)
    return m1.areaId == m2.areaId and m1.missionId == m2.missionId
end

Mission.reward = {}

function Mission:new(areaId, missionId)
    local obj = Container:new(Mission.getVarPrefix(areaId, missionId))
    setmetatable(obj, self)
    obj.areaId = areaId
    obj.missionId = missionId
    return obj
end

function Mission.getVarPrefix(areaId, missionId)
    return string.format("Mission[%d][%d]", areaId, missionId)
end

function Mission:getCheckArgs(player)
    return { player:getCurrentMission(self.areaId), player:getMissionStatus(self.areaId) }
end

-----------------------------------
-- Mission operations
-----------------------------------

function Mission:begin(player)
    player:addMission(self.areaId, self.missionId)
end

function Mission:complete(player)
    local didComplete = npcUtil.completeMission(player, self.areaId, self.missionId, self.reward)
    if didComplete then
        self:cleanup(player)
    end
    return didComplete
end
