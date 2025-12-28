---@meta

-- luacheck: ignore 241
---@class CClientEntityPairEntities
local CClientEntityPairEntities = {}

---Get an entity by ID, name, or entity object
---Raises an error if entity not found
---@param entityQuery string|integer|CBaseEntity Entity name, ID, or entity object
---@nodiscard
---@return CTestEntity entity The found entity wrapped with test assertions, or nil if not found
function CClientEntityPairEntities:get(entityQuery)
end

---Move to an entity's position
---Raises an error if entity not found
---@param entityQuery string|integer|CBaseEntity Entity name, ID, or entity object
---@return CTestEntity entity The entity at the destination, or nil if not found
function CClientEntityPairEntities:moveTo(entityQuery)
end

---Go to an entity and trigger/interact with it
---Raises an error if entity not found
---@param entityQuery string|integer|CBaseEntity Entity name, ID, or entity object
---@param expectedEvent? ExpectedEvent Expected event configuration
---@return CTestEntity entity The triggered entity, or nil if not found
function CClientEntityPairEntities:gotoAndTrigger(entityQuery, expectedEvent)
end

---Kill all mobs in a zone or specific mobs by name
---@param mobFilter? string|string[] Optional mob name filter or array of names to kill
---@return nil
function CClientEntityPairEntities:killMobs(mobFilter)
end
