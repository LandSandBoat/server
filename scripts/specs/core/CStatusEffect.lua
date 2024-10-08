---@meta

-- luacheck: ignore 241
---@class CStatusEffect
local CStatusEffect = {}

---@nodiscard
---@return integer
function CStatusEffect:getEffectType()
end

---@nodiscard
---@return integer
function CStatusEffect:getSubType()
end

---@nodiscard
---@return integer
function CStatusEffect:getPower()
end

---@nodiscard
---@return integer
function CStatusEffect:getSubPower()
end

---@nodiscard
---@return integer
function CStatusEffect:getTier()
end

---@nodiscard
---@return integer
function CStatusEffect:getDuration()
end

---@nodiscard
---@return integer
function CStatusEffect:getStartTime()
end

---@nodiscard
---@return integer
function CStatusEffect:getLastTick()
end

---@nodiscard
---@return integer
function CStatusEffect:getTimeRemaining()
end

---@nodiscard
---@return integer
function CStatusEffect:getTickCount()
end

---@nodiscard
---@return integer
function CStatusEffect:getTick()
end

---@nodiscard
---@return integer
function CStatusEffect:getIcon()
end

---@param icon integer
---@return nil
function CStatusEffect:setIcon(icon)
end

---@param power integer
---@return nil
function CStatusEffect:setPower(power)
end

---@param subpower integer
---@return nil
function CStatusEffect:setSubPower(subpower)
end

---@param tier integer
---@return nil
function CStatusEffect:setTier(tier)
end

---@param duration integer
---@return nil
function CStatusEffect:setDuration(duration)
end

---@param tick integer
---@return nil
function CStatusEffect:setTick(tick)
end

---@param time integer
---@return nil
function CStatusEffect:setStartTime(time)
end

---@return nil
function CStatusEffect:resetStartTime()
end

---@param mod integer
---@param amount integer
---@return nil
function CStatusEffect:addMod(mod, amount)
end

---@nodiscard
---@return integer
function CStatusEffect:getEffectFlags()
end

---@param flags integer
---@return nil
function CStatusEffect:setEffectFlags(flags)
end

---@param flag integer
---@return nil
function CStatusEffect:addEffectFlag(flag)
end

---@param flag integer
---@return nil
function CStatusEffect:delEffectFlag(flag)
end

---@nodiscard
---@param flag integer
---@return boolean
function CStatusEffect:hasEffectFlag(flag)
end
