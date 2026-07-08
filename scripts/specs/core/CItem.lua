---@meta

-- luacheck: ignore 241
---@class CItem
local CItem = {}

---@nodiscard
---@return integer
function CItem:getID()
end

---@nodiscard
---@return integer
function CItem:getSubID()
end

---@nodiscard
---@return integer
function CItem:getFlag()
end

---@nodiscard
---@return integer
function CItem:getAHCat()
end

---@nodiscard
---@return integer
function CItem:getQuantity()
end

---@nodiscard
---@return integer
function CItem:getLocationID()
end

---@nodiscard
---@return integer
function CItem:getSlotID()
end

---@nodiscard
---@return integer
function CItem:getTrialNumber()
end

---@nodiscard
---@return integer
function CItem:getWornUses()
end

---@nodiscard
---@return integer
function CItem:getBasePrice()
end

---@nodiscard
---@param type integer
---@return boolean
function CItem:isType(type)
end

---@param subtype integer
---@return nil
function CItem:setSubType(subtype)
end

---@nodiscard
---@param subtype integer
---@return boolean
function CItem:isSubType(subtype)
end

---@nodiscard
---@return xi.itemState
function CItem:state()
end

---@param reserved integer
---@return nil
function CItem:setReservedValue(reserved)
end

---@nodiscard
---@return integer
function CItem:getReservedValue()
end

---@nodiscard
---@return string
function CItem:getName()
end

---@nodiscard
---@return integer
function CItem:getILvl()
end

---@nodiscard
---@return integer
function CItem:getReqLvl()
end

---@nodiscard
---@param modID integer
---@return integer
function CItem:getMod(modID)
end

---@param modID integer
---@param power integer
---@return nil
function CItem:addMod(modID, power)
end

---@param modID integer
---@param power integer
---@return nil
function CItem:delMod(modID, power)
end

---@nodiscard
---@param slot integer
---@return table
function CItem:getAugment(slot)
end

---@nodiscard
---@return integer
function CItem:getSkillType()
end

---@nodiscard
---@return integer
function CItem:getWeaponskillPoints()
end

---@nodiscard
---@return boolean
function CItem:isTwoHanded()
end

---@nodiscard
---@return boolean
function CItem:isHandToHand()
end

---@nodiscard
---@return boolean
function CItem:isShield()
end

---@nodiscard
---@return integer
function CItem:getShieldSize()
end

---@nodiscard
---@return integer
function CItem:getShieldAbsorptionRate()
end

---@nodiscard
---@return string
function CItem:getSignature()
end

---@nodiscard
---@return integer
function CItem:getAppraisalID()
end

---@param id integer
---@return nil
function CItem:setAppraisalID(id)
end

---@nodiscard
---@return integer
function CItem:getCurrentCharges()
end

---@nodiscard
---@return boolean
function CItem:isInstalled()
end

---@nodiscard
---@return Exdata
function CItem:getExData()
end

---@param data Exdata
function CItem:setExData(data)
end

---@nodiscard
---@return table<integer, integer> # 0-indexed raw exdata bytes
function CItem:getExDataRaw()
end

---@param data table<integer, integer> # 0-indexed raw exdata bytes
function CItem:setExDataRaw(data)
end
