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

---@class dynamicEntityParams
---@field objtype? xi.objType            # Entity type. Default: xi.objType.NPC
---@field groupId? integer               # Mob group ID (for TYPE_MOB). Default: 0
---@field groupZoneId? integer           # Zone ID for mob group lookup (for TYPE_MOB). Default: 0
---@field allegiance? xi.allegiance      # Entity allegiance. Default: xi.allegiance.MOB
---@field name string                    # Entity name (required). Will be prefixed with "DE_" internally.
---@field packetName? string             # Display name sent in packets. Default: name
---@field x? number                      # X position. Default: 0.01
---@field y? number                      # Y position. Default: 0.01
---@field z? number                      # Z position. Default: 0.01
---@field rotation? integer              # Rotation (0-255). Default: 0
---@field look? integer|string           # Model ID (integer) or look string (e.g., "0x0000...")
---@field releaseIdOnDisappear? boolean  # Release target ID when entity disappears. Default: false
---@field entityFlags? integer           # Entity flags bitmask. Default: Uses Group/Pool ID Data
---@field namevis? integer               # (NPC) Name visibility flags. Default: 0
---@field widescan? integer              # (NPC) Widescan visibility. Default: 1
---@field onTrigger? function            # (NPC) onTrigger Function for Player Interaction
---@field mixins? table                  # (MOB) Table of mixins to apply.
---@field minLevel? integer              # (MOB) Minimum level override. Default: Uses Group ID Data
---@field maxLevel? integer              # (MOB) Maximum level override. Default: Uses Group ID Data
---@field dropId? integer                # (MOB) Drop table ID override. Default: Uses Group ID Data
---@field skillList? integer             # (MOB) Mob skill list ID override. Default: Uses Group ID Data
---@field spellList? integer             # (MOB) Spell list ID override. Default: Uses Group ID Data
---@field respawn? integer               # (MOB) Respawn time in seconds. 0 = no respawn.
---@field spawnType? integer             # (MOB) Spawn type flags.
---@field modelSize? integer             # (MOB) Model size override. Default: Uses Pool ID Data
---@field modelHitboxSize? integer       # (MOB) Hitbox size override. Default: Uses Pool ID Data
---@field isAggroable? boolean           # (MOB) Whether mob can aggro. Default: false
---@field specialSpawnAnimation? boolean # (MOB) Use special spawn animation. Default: false
---@field onMobDeath? function           # (MOB) Death Function. Default: function() end
---@param entityTable table<dynamicEntityParams>
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
