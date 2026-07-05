---@meta

---@return integer
function GarbageCollectStep()
end

---@return integer
function GarbageCollectFull()
end

---@param npcid integer
---@param command string
---@return nil
function SendEntityVisualPacket(npcid, command)
end

---@nodiscard
---@param zoneId integer
---@return CZone?
function GetZone(zoneId)
end

---@nodiscard
---@param itemId xi.item
---@return CItem?
function GetItemByID(itemId)
end

---@nodiscard
---@param itemId xi.item
---@return number
function GetItemFlagsByID(itemId)
end

---@nodiscard
---@param itemId xi.item
---@return number
function GetItemLevelRequirementsByID(itemId)
end

---@nodiscard
---@param npcid integer
---@param instanceObj CInstance?
---@return CBaseEntity?
function GetNPCByID(npcid, instanceObj)
end

---@nodiscard
---@param npcid integer
---@param instanceObj CInstance?
---@return CBaseEntity?
function GetMobByID(npcid, instanceObj)
end

---@nodiscard
---@param mobid integer
---@param instanceObj CInstance?
---@param arg3 boolean?
---@return CBaseEntity?
function GetEntityByID(mobid, instanceObj, arg3)
end

---@param updateType integer?
---@return nil
function WeekUpdateConquest(updateType)
end

---@nodiscard
---@param type integer
---@return integer
function GetRegionOwner(type)
end

---@nodiscard
---@param type integer
---@return integer
function GetRegionInfluence(type)
end

---@nodiscard
---@param nation integer
---@return integer
function GetNationRank(nation)
end

---@nodiscard
---@return integer
function GetConquestBalance()
end

---@nodiscard
---@return boolean
function IsConquestAlliance()
end

---@param requestingZoneId xi.zone
---@param executorZoneId xi.zone
---@param str string
---@return nil
function SendLuaFuncStringToZone(requestingZoneId, executorZoneId, str)
end

---@nodiscard
---@param id integer
---@return CItem?
function GetReadOnlyItem(id)
end

---@nodiscard
---@param id integer
---@return CAbility?
function GetAbility(id)
end

---@nodiscard
---@param id integer
---@return CSpell?
function GetSpell(id)
end

---@param mobid integer
---@param arg2 CInstance|integer?
---@param arg3 integer?
---@return CBaseEntity?
function SpawnMob(mobid, arg2, arg3)
end

---@param mobid integer
---@param arg2 CInstance|integer?
---@return nil
function DespawnMob(mobid, arg2)
end

---@nodiscard
---@param name string
---@return CBaseEntity?
function GetPlayerByName(name)
end

---@nodiscard
---@param pid integer
---@return CBaseEntity?
function GetPlayerByID(pid)
end

---@nodiscard
---@param playerId integer
---@return boolean
function PlayerHasValidSession(playerId)
end

---@nodiscard
---@param name string
---@return integer
function GetPlayerIDByName(name)
end

---@param playerId integer
---@param cellId integer
---@param posX number
---@param posY number
---@param posZ number
---@param rot integer
---@return nil
function SendToJailOffline(playerId, cellId, posX, posY, posZ, rot)
end

---@nodiscard
---@return integer
function GetSystemTime()
end

---@class LinkshellConciergeSlotRow
---@field slotIndex integer
---@field linkshellid integer
---@field ownerCharId integer
---@field groupKey integer
---@field flag integer
---@field lang integer
---@field membersGoal integer
---@field activeTier integer
---@field characteristics integer
---@field tz integer
---@field days integer
---@field times integer
---@field postedDate integer
---@field name string
---@field color integer

---@class LinkshellConciergeSlotData
---@field linkshellid integer
---@field ownerCharId integer
---@field groupKey integer
---@field flag integer
---@field lang integer
---@field membersGoal integer
---@field activeTier integer
---@field characteristics integer
---@field tz integer
---@field days integer
---@field times integer
---@field postedDate integer

---@nodiscard
---@param zoneId integer
---@return LinkshellConciergeSlotRow[]
function LoadLinkshellConciergeSlots(zoneId)
end

---@param zoneId integer
---@param slotIndex integer
---@param data LinkshellConciergeSlotData
---@return nil
function SetLinkshellConciergeSlot(zoneId, slotIndex, data)
end

---@param zoneId integer
---@param slotIndex integer
---@return nil
function DeleteLinkshellConciergeSlot(zoneId, slotIndex)
end

---@param zoneId integer
---@param linkshellid integer
---@return nil
function DecrementLinkshellConciergeMembersGoal(zoneId, linkshellid)
end

---@nodiscard
---@return integer
function JstMidnight()
end

---@nodiscard
---@return integer
function JstDayOfTheYear()
end

---@nodiscard
---@return integer
function JstDayOfTheMonth()
end

---@nodiscard
---@return integer
function JstDayOfTheWeek()
end

---@nodiscard
---@return integer
function JstYear()
end

---@nodiscard
---@return integer
function JstMonth()
end

---@nodiscard
---@return integer
function JstHour()
end

---@nodiscard
---@return integer
function NextConquestTally()
end

---@nodiscard
---@param intervalSeconds integer
---@return integer
function NextGameTime(intervalSeconds)
end

---@nodiscard
---@return integer
function NextJstDay()
end

---@nodiscard
---@return integer
function NextJstWeek()
end

---@nodiscard
---@return integer
function VanadielTime()
end

---@nodiscard
---@return integer
function VanadielTOTD()
end

---@nodiscard
---@return integer
function VanadielHour()
end

---@nodiscard
---@return integer
function VanadielMinute()
end

---@nodiscard
---@return integer
function VanadielDayOfTheYear()
end

---@nodiscard
---@return integer
function VanadielDayOfTheMonth()
end

---@nodiscard
---@return integer
function VanadielDayOfTheWeek()
end

---@nodiscard
---@return integer
function VanadielYear()
end

---@nodiscard
---@return integer
function VanadielMonth()
end

---@nodiscard
---@return integer
function VanadielUniqueDay()
end

---@nodiscard
---@return integer
function VanadielDayElement()
end

---@nodiscard
---@return integer
function VanadielMoonPhase()
end

---@nodiscard
---@return integer
function VanadielMoonDirection()
end

---@nodiscard
---@return integer
function VanadielRSERace()
end

---@nodiscard
---@return integer
function VanadielRSELocation()
end

---@param ElevatorID integer
---@return nil
function RunElevator(ElevatorID)
end

---@nodiscard
---@param id integer
---@return integer
function GetElevatorState(id)
end

---@nodiscard
---@param name string
---@return integer
function GetServerVariable(name)
end

---@param name string
---@param value integer
---@param expiry integer?
---@return nil
function SetServerVariable(name, value, expiry)
end

---@nodiscard
---@param varName string
---@return integer
function GetVolatileServerVariable(varName)
end

---@param name string
---@param value integer
---@param expiry integer?
---@return nil
function SetVolatileServerVariable(name, value, expiry)
end

---@nodiscard
---@param charId integer
---@param varName string
---@return integer
function GetCharVar(charId, varName)
end

---@param charId integer
---@param varName string
---@param value integer
---@param expiry integer?
---@return nil
function SetCharVar(charId, varName, value, expiry)
end

---@param varName string
---@return nil
function ClearCharVarFromAll(varName)
end

---@return nil
function Terminate()
end

---@param target CBaseEntity
---@param table table
---@param offset number
---@param degrees number
---@return nil
function DrawIn(target, table, offset, degrees)
end

---@nodiscard
---@param mobid integer
---@return integer
function GetMobRespawnTime(mobid)
end

---@param mobid integer
---@param allowRespawn boolean
---@return nil
function DisallowRespawn(mobid, allowRespawn)
end

---@nodiscard
---@param minutes integer
---@return table
function GetRecentFishers(minutes)
end

---@nodiscard
---@param table table
---@param radius number
---@param theta number
---@return table
function NearLocation(table, radius, theta)
end

---@nodiscard
---@param target CBaseEntity
---@param distance number
---@param theta number
---@return table
function GetFurthestValidPosition(target, distance, theta)
end

---@nodiscard
---@param PLuaBaseEntity CBaseEntity
---@param dial integer
---@return integer
function SelectDailyItem(PLuaBaseEntity, dial)
end

---@nodiscard
---@param name string
---@return integer
function GetItemIDByName(name)
end

---@param playerName string
---@param itemId integer
---@param quantity integer
---@param senderText string
---@return integer
function SendItemToDeliveryBox(playerName, itemId, quantity, senderText)
end

---@param recordTable table
---@return nil
function RoeParseRecords(recordTable)
end

---@param timedSchedule table
---@return nil
function RoeParseTimed(timedSchedule)
end

---@param expToDifficultyTable table
---@param incrediblyEasyPreyLevel integer
---@param incrediblyEasyPreyMinExp integer
---@return nil
function LoadExpDifficultyCurves(expToDifficultyTable, incrediblyEasyPreyLevel, incrediblyEasyPreyMinExp)
end

--@return table
function GetFishingContest()
end

--@return nil
function InitNewFishingContest()
end

--@param fishId integer
--@param measure integer
--@param criteria integer
--@return nil
function SetContestParameters(fishId, measure, criteria)
end

--@return nil
function ProgressFishingContest()
end

--@return nil
function InitializeFishingContestSystem()
end

-- Generates a normally distributed number (mean, standard deviation). Optional
-- bounds truncate the distribution to [lower, upper] exactly, with no rejection
-- sampling; pass nil for lower to set only an upper bound.
-- Examples:
-- math.randomNormal(3.5, 1.5)         : No bounds.
-- math.randomNormal(3.5, 1.5, 2, 7)   : Truncated to [2, 7].
-- math.randomNormal(3.5, 1.5, 0)      : Lower bound 0, no upper bound.
-- math.randomNormal(3.5, 1.5, nil, 7) : No lower bound, upper bound 7.
---@nodiscard
---@param mean number
---@param stddev number Standard deviation; values <= 0 collapse the distribution to mean.
---@param lower number? Optional lower bound.
---@param upper number? Optional upper bound.
---@return number
function math.randomNormal(mean, stddev, lower, upper)
end

-- Generates a pseudo-random integer in [lower, upper] (both endpoints inclusive).
-- Identical to math.random(lower, upper), but explicit about its semantics at the
-- call site. Fractional bounds are rounded to the nearest integer.
---@nodiscard
---@param lower number
---@param upper number
---@return integer
function math.randomInt(lower, upper)
end

-- Generates a pseudo-random double in [lower, upper) (half-open), regardless of
-- whether the bounds are whole numbers. This is the only way to request a float
-- range with whole-number bounds: math.random(2.0, 7.0) rolls integers, because
-- LuaJIT cannot tell 7.0 from 7.
---@nodiscard
---@param lower number
---@param upper number
---@return number
function math.randomFloat(lower, upper)
end
