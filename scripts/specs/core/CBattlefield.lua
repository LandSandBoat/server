---@meta

---@class CBattlefield
local CBattlefield = {}

---@return integer
function CBattlefield:getID()
end

---@return integer
function CBattlefield:getZoneID()
end

---@return integer
function CBattlefield:getArea()
end

---@return integer
function CBattlefield:getTimeLimit()
end

---@return integer
function CBattlefield:getTimeInside()
end

---@return integer
function CBattlefield:getRemainingTime()
end

---@return integer
function CBattlefield:getFightTick()
end

---@return integer
function CBattlefield:getWipeTime()
end

---@return integer
function CBattlefield:getFightTime()
end

---@return integer
function CBattlefield:getMaxParticipants()
end

---@return integer
function CBattlefield:getPlayerCount()
end

---@return table
function CBattlefield:getPlayers()
end

---@return table
function CBattlefield:getPlayersAndTrusts()
end

---@return table
function CBattlefield:getMobs(required, adds)
end

---@return table
function CBattlefield:getNPCs()
end

---@return table
function CBattlefield:getAllies()
end

---@return table
function CBattlefield:getRecord()
end

---@return integer
function CBattlefield:getStatus()
end

---@return integer
function CBattlefield:getLocalVar(name)
end

---@return integer
function CBattlefield:getLastTimeUpdate()
end

---@return table
function CBattlefield:getInitiator()
end

---@return integer
function CBattlefield:getArmouryCrate()
end

---@param seconds integer
---@return nil
function CBattlefield:setLastTimeUpdate(seconds)
end

---@param seconds integer
---@return nil
function CBattlefield:setTimeLimit(seconds)
end

---@param seconds integer
---@return nil
function CBattlefield:setWipeTime(seconds)
end

---@param name string
---@param seconds integer
---@return nil
function CBattlefield:setRecord(name, seconds)
end

---@param status integer
---@return nil
function CBattlefield:setStatus(status)
end

---@param name string
---@param value integer
---@return nil
function CBattlefield:setLocalVar(name, value)
end

---@param targid integer
---@param ally boolean
---@param inBattlefield boolean
---@return CBaseEntity?
function CBattlefield:insertEntity(targid, ally, inBattlefield)
end

---@param cleanup boolean
---@return boolean
function CBattlefield:cleanup(cleanup)
end

---@return nil
function CBattlefield:win()
end

---@return nil
function CBattlefield:lose()
end

---@param groups table
---@param hasMultipleArenas boolean
---@return nil
function CBattlefield:addGroups(groups, hasMultipleArenas)
end
