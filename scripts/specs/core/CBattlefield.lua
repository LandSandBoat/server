---@meta

-- luacheck: ignore 241
---@class CBattlefield
local CBattlefield = {}

---@nodiscard
---@return integer
function CBattlefield:getID()
end

---@nodiscard
---@return integer
function CBattlefield:getZoneID()
end

---@nodiscard
---@return integer
function CBattlefield:getArea()
end

---@nodiscard
---@return integer
function CBattlefield:getTimeLimit()
end

---@nodiscard
---@return integer
function CBattlefield:getTimeInside()
end

---@nodiscard
---@return integer
function CBattlefield:getRemainingTime()
end

---@nodiscard
---@return integer
function CBattlefield:getFightTick()
end

---@nodiscard
---@return integer
function CBattlefield:getWipeTime()
end

---@nodiscard
---@return integer
function CBattlefield:getFightTime()
end

---@nodiscard
---@return integer
function CBattlefield:getMaxParticipants()
end

---@nodiscard
---@return integer
function CBattlefield:getPlayerCount()
end

---@nodiscard
---@return table
function CBattlefield:getPlayers()
end

---@nodiscard
---@return table
function CBattlefield:getPlayersAndTrusts()
end

---@nodiscard
---@return table
function CBattlefield:getMobs(required, adds)
end

---@nodiscard
---@return table
function CBattlefield:getNPCs()
end

---@nodiscard
---@return table
function CBattlefield:getAllies()
end

---@nodiscard
---@return table
function CBattlefield:getRecord()
end

---@nodiscard
---@return integer
function CBattlefield:getStatus()
end

---@nodiscard
---@return integer
function CBattlefield:getLocalVar(name)
end

---@nodiscard
---@return integer
function CBattlefield:getLastTimeUpdate()
end

---@nodiscard
---@return table
function CBattlefield:getInitiator()
end

---@nodiscard
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
