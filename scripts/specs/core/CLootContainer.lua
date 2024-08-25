---@meta

-- luacheck: ignore 241
---@class CLootContainer
local CLootContainer = {}

---@param item integer
---@param rate integer
---@param quantity integer?
---@return nil
function CLootContainer:addItem(item, rate, quantity)
end

---@param groupRate integer
---@param items table
---@return nil
function CLootContainer:addGroup(groupRate, items)
end

---@param item integer
---@param rate integer
---@param quantity integer?
---@return nil
function CLootContainer:addItemFixed(item, rate, quantity)
end

---@param groupRate integer
---@param items table
---@return nil
function CLootContainer:addGroupFixed(groupRate, items)
end
