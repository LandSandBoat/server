---@meta

-- luacheck: ignore 241
---@class CInstance
local CInstance = {}

---@return integer
function CInstance:getID()
end

---@return string
function CInstance:getName()
end

---@return CZone
function CInstance:getZone()
end

---@return integer
function CInstance:getEntranceZoneID()
end

---@return table
function CInstance:getAllies()
end

---@return table
function CInstance:getChars()
end

---@return table
function CInstance:getMobs()
end

---@return table
function CInstance:getNpcs()
end

---@return table
function CInstance:getPets()
end

---@return integer
function CInstance:getTimeLimit()
end

---@return table
function CInstance:getEntryPos()
end

---@return integer
function CInstance:getLevelCap()
end

---@return integer
function CInstance:getLastTimeUpdate()
end

---@return integer
function CInstance:getProgress()
end

---@return integer
function CInstance:getWipeTime()
end

---@param targid integer
---@param filterObj integer?
---@return CBaseEntity?
function CInstance:getEntity(targid, filterObj)
end

---@return integer
function CInstance:getStage()
end

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
