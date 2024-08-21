---@meta

---@class CZone
local CZone = {}

---@return integer
function CZone:getLocalVar(key)
end

---@param key string
---@param value integer
---@return nil
function CZone:setLocalVar(key, value)
end

---@return nil
function resetLocalVars()
end

---@return nil
function CZone:registerTriggerArea(triggerAreaID, x1, y1, z1, x2, y2, z2)
end

---@deprecated
---@return nil
function levelRestriction()
end

---@return table
function CZone:getPlayers()
end

---@return table
function CZone:getNPCs()
end

---@return table
function CZone:getMobs()
end

---@return zone
function CZone:getID()
end

---@return string
function CZone:getName()
end

---@return region
function CZone:getRegionID()
end

---@return integer
function CZone:getTypeMask()
end

---@param charID integer
---@return CBattlefield?
function CZone:getBattlefieldByInitiator(charID)
end

---@return weather
function CZone:getWeather()
end

---@return integer
function CZone:getUptime()
end

---@return nil
function CZone:reloadNavmesh()
end

---@param position table
---@return boolean
function CZone:isNavigablePoint(position)
end

---@param entityTable table
---@return CBaseEntity?
function CZone:insertDynamicEntity(entityTable)
end

---@return integer
function CZone:getSoloBattleMusic()
end

---@return integer
function CZone:getPartyBattleMusic()
end

---@return integer
function CZone:getBackgroundMusicDay()
end

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

---@param name string
---@return table
function queryEntitiesByName(name)
end
