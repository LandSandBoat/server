---@meta

---@class CAbility
local CAbility = {}

---@return integer
function CAbility:getID()
end

---@return integer
function CAbility:getMsg()
end

---@return integer
function CAbility:getRecast()
end

---@return integer
function CAbility:getRecastID()
end

---@return integer
function CAbility:getRange()
end

---@return string
function CAbility:getName()
end

---@return integer
function CAbility:getAnimation()
end

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

---@return integer
function CAbility:getCE()
end

---@param ce integer
---@return nil
function CAbility:setCE(ce)
end

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
