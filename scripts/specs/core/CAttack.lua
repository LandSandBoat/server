---@meta

-- luacheck: ignore 241
---@class CAttack
local CAttack = {}

---@nodiscard
---@return CBaseEntity?
function CAttack:getAttacker()
end

---@nodiscard
---@return CBaseEntity?
function CAttack:getVictim()
end

---@nodiscard
---@return CBaseEntity?
function CAttack:GetTAEntity()
end

---@nodiscard
---@return boolean
function CAttack:isH2H()
end

---@nodiscard
---@return integer
function CAttack:getWeaponSlot()
end

---@nodiscard
---@return boolean
function CAttack:isFirstSwing()
end

---@nodiscard
---@return boolean
function CAttack:isSA()
end

---@param val boolean
---@return nil
function CAttack:setSA(val)
end

---@nodiscard
---@return boolean
function CAttack:isTA()
end

---@param val boolean
---@return nil
function CAttack:setTA(val)
end

---@nodiscard
---@return PHYSICAL_ATTACK_TYPE
function CAttack:getAttackType()
end

---@param type PHYSICAL_ATTACK_TYPE
---@return nil
function CAttack:setAttackType(type)
end

---@nodiscard
---@return number
function CAttack:getDamageRatio()
end

---@nodiscard
---@return boolean
function CAttack:isCritical()
end

---@param critical boolean
---@return nil
function CAttack:setCritical(critical)
end
