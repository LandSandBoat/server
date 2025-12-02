---@meta

-- Test-specific extensions to CBaseEntity
-- These fields are only available in the test environment

-- luacheck: ignore 241
---@class CTestEntityAssertions
---@field no CTestEntityAssertions Negated assertion object
local CTestEntityAssertions = {}

---Assert entity is in expected zone
---@param expectedZone xi.zone
---@return CTestEntityAssertions self for chaining
function CTestEntityAssertions:inZone(expectedZone)
end

---Assert entity has local variable with expected value
---@param varName string
---@param expectedValue integer
---@return CTestEntityAssertions self for chaining
function CTestEntityAssertions:hasLocalVar(varName, expectedValue)
end

---Assert entity has specified status effect
---@param effectId xi.effect
---@return CTestEntityAssertions self for chaining
function CTestEntityAssertions:hasEffect(effectId)
end

---Assert entity has specified status animation
---@param animation xi.animation
---@return CTestEntityAssertions self for chaining
function CTestEntityAssertions:hasAnimation(animation)
end

---Assert player has expected nation rank
---@param expectedRank integer
---@return CTestEntityAssertions self for chaining
function CTestEntityAssertions:hasNationRank(expectedRank)
end

---Assert player has specified key item
---@param keyItemId xi.ki
---@return CTestEntityAssertions self for chaining
function CTestEntityAssertions:hasKI(keyItemId)
end

---Assert player has expected current mission
---@param logId xi.mission.log_id
---@param expectedMission integer
---@return CTestEntityAssertions self for chaining
function CTestEntityAssertions:hasMission(logId, expectedMission)
end

---Assert player has completed specified mission
---@param logId xi.mission.log_id
---@param missionId integer
---@return CTestEntityAssertions self for chaining
function CTestEntityAssertions:hasCompletedMission(logId, missionId)
end

---Assert player has specified item in inventory
---@param itemId xi.item
---@return CTestEntityAssertions self for chaining
function CTestEntityAssertions:hasItem(itemId)
end

---Assert entity has modifier with expected value
---@param modifierId xi.mod
---@param expectedValue integer
---@return CTestEntityAssertions self for chaining
function CTestEntityAssertions:hasModifier(modifierId, expectedValue)
end

---Assert entity is currently spawned
---@return CTestEntityAssertions self for chaining
function CTestEntityAssertions:isSpawned()
end

---Assert entity is currently alive
---@return CTestEntityAssertions self for chaining
function CTestEntityAssertions:isAlive()
end

---Assert player has specified quest
---@param logId xi.questLog
---@param questId integer
---@return CTestEntityAssertions self for chaining
function CTestEntityAssertions:hasQuest(logId, questId)
end

---Assert player has completed specified quest
---@param logId xi.questLog
---@param questId integer
---@return CTestEntityAssertions self for chaining
function CTestEntityAssertions:hasCompletedQuest(logId, questId)
end

---Assert player has at least the specified amount of gil
---@param amount integer
---@return CTestEntityAssertions self for chaining
function CTestEntityAssertions:hasGil(amount)
end
