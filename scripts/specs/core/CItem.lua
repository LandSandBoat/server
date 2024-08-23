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

---@param name string
---@param mobFamily integer
---@param zeni integer
---@param skillIndex integer
---@param fp integer
---@return nil
function CItem:setSoulPlateData(name, mobFamily, zeni, skillIndex, fp)
end

---@nodiscard
---@return table
function CItem:getSoulPlateData()
end

---@nodiscard
---@return table
function CItem:getExData()
end

---@param newData table
---@return nil
function CItem:setExData(newData)
end
