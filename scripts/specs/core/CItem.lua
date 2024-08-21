---@meta

---@class CItem
local CItem = {}

---@return integer
function CItem:getID()
end

---@return integer
function CItem:getSubID()
end

---@return integer
function CItem:getFlag()
end

---@return integer
function CItem:getAHCat()
end

---@return integer
function CItem:getQuantity()
end

---@return integer
function CItem:getLocationID()
end

---@return integer
function CItem:getSlotID()
end

---@return integer
function CItem:getTrialNumber()
end

---@return integer
function CItem:getWornUses()
end

---@return integer
function CItem:getBasePrice()
end

---@param type integer
---@return boolean
function CItem:isType(type)
end

---@param subtype integer
---@return nil
function CItem:setSubType(subtype)
end

---@param subtype integer
---@return boolean
function CItem:isSubType(subtype)
end

---@param reserved integer
---@return nil
function CItem:setReservedValue(reserved)
end

---@return integer
function CItem:getReservedValue()
end

---@return string
function CItem:getName()
end

---@return integer
function CItem:getILvl()
end

---@return integer
function CItem:getReqLvl()
end

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

---@param slot integer
---@return table
function CItem:getAugment(slot)
end

---@return integer
function CItem:getSkillType()
end

---@return integer
function CItem:getWeaponskillPoints()
end

---@return boolean
function CItem:isTwoHanded()
end

---@return boolean
function CItem:isHandToHand()
end

---@return boolean
function CItem:isShield()
end

---@return integer
function CItem:getShieldSize()
end

---@return integer
function CItem:getShieldAbsorptionRate()
end

---@return string
function CItem:getSignature()
end

---@return integer
function CItem:getAppraisalID()
end

---@param id integer
---@return nil
function CItem:setAppraisalID(id)
end

---@return integer
function CItem:getCurrentCharges()
end

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

---@return table
function CItem:getSoulPlateData()
end

---@return table
function CItem:getExData()
end

---@param newData table
---@return nil
function CItem:setExData(newData)
end
