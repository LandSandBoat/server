---@meta

-- luacheck: ignore 241
---@class CInstance
local CInstance = {}

---@nodiscard
---@return integer
function CInstance:getID()
end

---@nodiscard
---@return string
function CInstance:getName()
end

---@nodiscard
---@return CZone
function CInstance:getZone()
end

---@nodiscard
---@return integer
function CInstance:getEntranceZoneID()
end

---@nodiscard
---@return table
function CInstance:getAllies()
end

---@nodiscard
---@return table
function CInstance:getChars()
end

---@nodiscard
---@return table
function CInstance:getMobs()
end

---@nodiscard
---@return table
function CInstance:getNpcs()
end

---@nodiscard
---@return table
function CInstance:getPets()
end

---@nodiscard
---@return integer
function CInstance:getTimeLimit()
end

---@nodiscard
---@return table
function CInstance:getEntryPos()
end

---@nodiscard
---@return integer
function CInstance:getLevelCap()
end

---@nodiscard
---@return integer
function CInstance:getLastTimeUpdate()
end

---@nodiscard
---@return integer
function CInstance:getProgress()
end

---@nodiscard
---@return integer
function CInstance:getWipeTime()
end

---@nodiscard
---@param targid integer
---@param filterObj integer?
---@return CBaseEntity?
function CInstance:getEntity(targid, filterObj)
end

---@nodiscard
---@return integer
function CInstance:getStage()
end

---@nodiscard
---@param name string
---@return integer
function CInstance:getLocalVar(name)
end

---@param cap integer
---@return nil
function CInstance:setLevelCap(cap)
end

---@param ms integer
---@return nil
function CInstance:setLastTimeUpdate(ms)
end

---@param seconds integer
---@return nil
function CInstance:setTimeLimit(seconds)
end

---@param progress integer
---@return nil
function CInstance:setProgress(progress)
end

---@param ms integer
---@return nil
function CInstance:setWipeTime(ms)
end

---@param stage integer
---@return nil
function CInstance:setStage(stage)
end

---@param name string
---@param value integer
---@return nil
function CInstance:setLocalVar(name, value)
end

---@return nil
function CInstance:fail()
end

---@return boolean
function CInstance:failed()
end

---@return nil
function CInstance:complete()
end

---@return boolean
function CInstance:completed()
end

---@param groupid integer
---@return CBaseEntity?
function CInstance:insertAlly(groupid)
end

---@param entityTable table
---@return CBaseEntity?
function CInstance:insertDynamicEntity(entityTable)
end
