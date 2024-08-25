---@meta

-- luacheck: ignore 241
---@class CTradeContainer
local CTradeContainer = {}

---@nodiscard
---@return integer
function CTradeContainer:getGil()
end

---@nodiscard
---@param SlotIDObj integer?
---@return CItem?
function CTradeContainer:getItem(SlotIDObj)
end

---@nodiscard
---@param SlotIDObj integer?
---@return integer
function CTradeContainer:getItemId(SlotIDObj)
end

---@nodiscard
---@param SlotIDObj integer?
---@return integer
function CTradeContainer:getItemSubId(SlotIDObj)
end

---@nodiscard
---@param itemID integer
---@return integer
function CTradeContainer:getItemQty(itemID)
end

---@nodiscard
---@param itemID integer
---@param quantity integer
---@return boolean
function CTradeContainer:hasItemQty(itemID, quantity)
end

---@nodiscard
---@param slotID integer
---@return integer
function CTradeContainer:getSlotQty(slotID)
end

---@nodiscard
---@return integer
function CTradeContainer:getItemCount()
end

---@nodiscard
---@return integer
function CTradeContainer:getSlotCount()
end

---@param itemID integer
---@param amountObj integer
---@return boolean
function CTradeContainer:confirmItem(itemID, amountObj)
end

---@param slotID integer
---@param amountObj integer
---@return boolean
function CTradeContainer:confirmSlot(slotID, amountObj)
end
