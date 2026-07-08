---@meta

-- Test entity base class for all entities in tests (mobs, NPCs, etc.)
-- Provides common test functionality and assertions

-- luacheck: ignore 241
---@class CTestEntity : CBaseEntity
---@field assert CTestEntityAssertions Assertion methods for this entity
local CTestEntity = {}

---Update the underlying entity pointer.
---Used internally when entity object changes (e.g., during zone changes).
---@param entity CBaseEntity The new entity pointer
---@return nil
function CTestEntity:setEntity(entity)
end

---Respawn a dead mob entity by triggering its death sequence and then spawning it again.
---Will raise an error if called on non-mob entities or if the mob doesn't respawn properly.
---@return nil
function CTestEntity:respawn()
end

---Despawn a mob entity immediately.
---Will raise an error if called on non-mob entities.
---@return nil
function CTestEntity:despawn()
end
