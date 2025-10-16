---@meta

-- luacheck: ignore 241
---@class CSimulation
local CSimulation = {}

---@class SpawnPlayerParams
---@field zone? xi.zone
---@field job? xi.job
---@field level? integer
---@field race? xi.race
---@field new? boolean If true, spawn as a new player with zero playtime (for testing first login scenarios)

---Spawn a test player with specified configuration
---@param params? SpawnPlayerParams
---@nodiscard
---@return CClientEntityPair player The test player (combined client and entity)
function CSimulation:spawnPlayer(params)
end

---@param ... xi.tick? Task boundary types to advance to. Defaults to xi.tick.ZONE if none provided.
---@return nil
function CSimulation:tick(...)
end

---@param entity CBaseEntity
---@return nil
function CSimulation:tickEntity(entity)
end

---@param regionId xi.region
---@param nationId xi.nation
---@return nil
function CSimulation:setRegionOwner(regionId, nationId)
end

---Set the random seed for the simulation's RNG
---@param seed integer
---@return nil
function CSimulation:setSeed(seed)
end

---Sets a new random seed
---@return nil
function CSimulation:seed()
end

---Advances the steady clock.
---@param seconds integer
---@return nil
function CSimulation:skipTime(seconds)
end

---@param hour integer
---@param minute integer
---@return nil
function CSimulation:setVanaTime(hour, minute)
end

---@param day xi.day
---@return nil
function CSimulation:setVanaDay(day)
end

---Skip to midnight (00:00) of the next Vana'diel day
---@return nil
function CSimulation:skipToNextVanaDay()
end
