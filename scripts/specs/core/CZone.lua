---@meta

-- luacheck: ignore 241
---@class CZone
local CZone = {}

---@nodiscard
---@return integer
function CZone:getLocalVar(key)
end

---@param key string
---@param value integer
---@return nil
function CZone:setLocalVar(key, value)
end

---@return nil
function CZone:resetLocalVars()
end

---@return nil
function CZone:registerCuboidTriggerArea(triggerAreaID, xMin, yMin, zMin, xMax, yMax, zMax)
end

---@return nil
function CZone:registerCylindricalTriggerArea(triggerAreaID, xPos, zPos, radius)
end

---@return nil
function CZone:registerSphericalTriggerArea(triggerAreaID, xPos, yPos, zPos, radius)
end

---@deprecated
---@return nil
function CZone:levelRestriction()
end

---@nodiscard
---@return table
function CZone:getPlayers()
end

---@nodiscard
---@return table
function CZone:getNPCs()
end

---@nodiscard
---@return table
function CZone:getMobs()
end

---@nodiscard
---@return xi.zone
function CZone:getID()
end

---@nodiscard
---@return string
function CZone:getName()
end

---@nodiscard
---@return xi.region
function CZone:getRegionID()
end

---@nodiscard
---@return integer
function CZone:getTypeMask()
end

---@nodiscard
---@param charID integer
---@return CBattlefield?
function CZone:getBattlefieldByInitiator(charID) -- Unused
end

---@nodiscard
---@return xi.weather
function CZone:getWeather()
end

---@nodiscard
---@return integer
function CZone:getUptime()
end

---@return nil
function CZone:reloadNavmesh()
end

---@nodiscard
---@param position table
---@return boolean
function CZone:isNavigablePoint(position)
end

---@param entityTable table
---@return CBaseEntity?
function CZone:insertDynamicEntity(entityTable)
end

---@nodiscard
---@return integer
function CZone:getSoloBattleMusic()
end

---@nodiscard
---@return integer
function CZone:getPartyBattleMusic()
end

---@nodiscard
---@return integer
function CZone:getBackgroundMusicDay()
end

---@nodiscard
---@return integer
function CZone:getBackgroundMusicNight()
end

---@param musicId integer
---@return nil
function CZone:setSoloBattleMusic(musicId)
end

---@param musicId integer
---@return nil
function CZone:setPartyBattleMusic(musicId)
end

---@param musicId integer
---@return nil
function CZone:setBackgroundMusicDay(musicId)
end

---@param musicId integer
---@return nil
function CZone:setBackgroundMusicNight(musicId)
end

---@nodiscard
---@param name string
---@return table
function CZone:queryEntitiesByName(name)
end
