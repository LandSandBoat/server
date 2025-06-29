---@meta

-- luacheck: ignore 241
---@class CSimulation
local CSimulation = {}

---@nodiscard
---@param zoneId integer?
---@return CSimClient
function CSimulation:createPlayerClient(zoneId)
end

---@param zoneIds ...integer?
---@return nil
function CSimulation:loadZones(zoneIds)
end

---@param seconds integer?
---@return nil
function CSimulation:tick(seconds)
end

---@param entity CBaseEntity
---@return nil
function CSimulation:tickEntity(entity)
end

---@param seconds integer
---@return nil
function CSimulation:addSeconds(seconds)
end

---@param regionId integer
---@param nationId integer
---@return nil
function CSimulation:setRegionOwner(regionId, nationId)
end

---@return nil
function CSimulation:clean()
end

---@param seed integer
---@return nil
function CSimulation:setSeed(seed)
end

---@return nil
function CSimulation:seed()
end

---@nodiscard
---@return string[]
function CSimulation:getLogs()
end

---@return nil
function CSimulation:clearLogs()
end
