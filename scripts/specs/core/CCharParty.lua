---@meta

-- luacheck: ignore 241
---@class CCharParty
local CCharParty = {}

---@nodiscard
---@return integer
function CCharParty:getMemberCount()
end

---@nodiscard
---@return integer
function CCharParty:getPartyId()
end

---@nodiscard
---@return integer
function CCharParty:getLeaderId()
end

---@nodiscard
---@return integer
function CCharParty:getQuartermasterId()
end

---@nodiscard
---@return integer
function CCharParty:getSyncTargetId()
end

---@param uniqueNo integer
---@return CBaseEntity?
function CCharParty:getMemberById(uniqueNo)
end

---@param memberName string
---@return CBaseEntity?
function CCharParty:getMemberByName(memberName)
end

---@nodiscard
---@return table
function CCharParty:getMembers()
end

---@nodiscard
---@return table
function CCharParty:getPlayers()
end

---@nodiscard
---@return table
function CCharParty:getTrusts()
end

---@nodiscard
---@return CBaseEntity?
function CCharParty:getLeader()
end

---@nodiscard
---@return CBaseEntity?
function CCharParty:getQuartermaster()
end

---@nodiscard
---@return CBaseEntity?
function CCharParty:getSyncTarget()
end

---@nodiscard
---@return boolean
function CCharParty:isFull()
end

---@nodiscard
---@return integer
function CCharParty:getTimeLastMemberJoined()
end

---@nodiscard
---@return boolean
function CCharParty:hasTrusts()
end

---@nodiscard
---@return boolean
function CCharParty:isTrustOnlyParty()
end

---@param entity CBaseEntity
---@return nil
function CCharParty:refreshSync(entity)
end

---@param uniqueNo integer
---@return nil
function CCharParty:setLeader(uniqueNo)
end

---@param uniqueNo integer
---@return nil
function CCharParty:setSyncTarget(uniqueNo)
end

---@param reason integer
---@return nil
function CCharParty:clearSyncTarget(reason)
end

---@param uniqueNo integer
---@return nil
function CCharParty:setQuartermaster(uniqueNo)
end

---@param uniqueNo integer
---@return nil
function CCharParty:addMember(uniqueNo)
end

---@param uniqueNo integer
---@return nil
function CCharParty:removeMember(uniqueNo)
end

---@return nil
function CCharParty:disband()
end
