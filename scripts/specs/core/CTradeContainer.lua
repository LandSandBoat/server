---@meta

---@class CTradeContainer
local CTradeContainer = {}

---@return integer
function CTradeContainer:getGil()
end

---@param SlotIDObj integer?
---@return CItem?
function CTradeContainer:getItem(SlotIDObj)
end

---@param SlotIDObj integer?
---@return integer
function CTradeContainer:getItemId(SlotIDObj)
end

---@param SlotIDObj integer?
---@return integer
function CTradeContainer:getItemSubId(SlotIDObj)
end

---@param itemID integer
---@return integer
function CTradeContainer:getItemQty(itemID)
end

---@param itemID integer
---@param quantity integer
---@return boolean
function CTradeContainer:hasItemQty(itemID, quantity)
end

---@param slotID integer
---@return integer
function CTradeContainer:getSlotQty(slotID)
end

---@return integer
function CTradeContainer:getItemCount()
end

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
