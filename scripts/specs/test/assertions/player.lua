---@meta

-- luacheck: ignore 241
---@class luassert.internal
local internal = {}

---Perform an assertion on a player object. This will allow you to call further
---function to perform an assertion.
---@param entity CBaseEntity The player entity
---@return luassert.player playerAssert A new object that has further assert function options
function internal.player(entity)
end

-- luacheck: ignore 241
---@class luassert.player
local player = {}

player.has = player
player.no = player

---Prepare assertions on a specific quest
---@param logId xi.questLog The quest log identifier
---@param id integer The quest identifier
---@return luassert.quest
function player.quest(logId, id)
end

---Assert that player possess a specific item
---@param itemId xi.item The item ID
---@return luassert.player
function player.item(itemId)
end

---Assert that player possess a specific key item
---@param keyItemId xi.keyItem The key item ID
---@return luassert.player
function player.ki(keyItemId)
end

---Assert that player has a modifier with value
---@param modId xi.mod The modifier ID
---@param expected integer Value to compare against
---@return luassert.player
function player.modifier(modId, expected)
end

---Assert that player has a status effect
---@param effectId xi.effect The modifier ID
---@return luassert.player
function player.effect(effectId)
end

---Assert that player is on a given mission
---@param logId xi.mission.log_id The mission log ID
---@param missionId integer The mission ID
---@return luassert.player
function player.mission(logId, missionId)
end

---Assert that player has a specific nation rank
---@param rank integer Expected rank
---@return luassert.player
function player.nationRank(rank)
end
