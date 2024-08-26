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

---@param zoneId xi.zone
---@param str string
---@return nil
function SendLuaFuncStringToZone(zoneId, str)
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

---@nodiscard
---@return integer
function JstMidnight()
end

---@nodiscard
---@return integer
function JstWeekday()
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

---@nodiscard
---@param offset integer
---@return boolean
function SetVanadielTimeOffset(offset)
end

---@nodiscard
---@return boolean
function IsMoonNew()
end

---@nodiscard
---@return boolean
function IsMoonFull()
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

---@param mobid integer
---@return nil
function UpdateNMSpawnPoint(mobid)
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
