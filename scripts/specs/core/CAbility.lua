---@meta

-- luacheck: ignore 241
---@class CAbility
local CAbility = {}

---@nodiscard
---@return integer
function CAbility:getID()
end

---@nodiscard
---@return integer
function CAbility:getMsg()
end

---@nodiscard
---@return integer
function CAbility:getRecast()
end

---@nodiscard
---@return integer
function CAbility:getRecastID()
end

---@nodiscard
---@return integer
function CAbility:getRange()
end

---@nodiscard
---@return string
function CAbility:getName()
end

---@nodiscard
---@return integer
function CAbility:getAnimation()
end

---@nodiscard
---@return integer
function CAbility:getAddType()
end

---@param messageId integer
---@return nil
function CAbility:setMsg(messageId)
end

---@param animationID integer
---@return nil
function CAbility:setAnimation(animationID)
end

---@param recastTime integer
---@return nil
function CAbility:setRecast(recastTime)
end

---@nodiscard
---@return integer
function CAbility:getCE()
end

---@param ce integer
---@return nil
function CAbility:setCE(ce)
end

---@nodiscard
---@return integer
function CAbility:getVE()
end

---@param ve integer
---@return nil
function CAbility:setVE(ve)
end

---@param range integer
---@return nil
function CAbility:setRange(range)
end
