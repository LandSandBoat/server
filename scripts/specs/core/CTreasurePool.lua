---@meta

-- luacheck: ignore 241
---@class CTreasurePool
local CTreasurePool = {}

---@nodiscard
---@return xi.treasurePool
function CTreasurePool:getType()
end

---@nodiscard
---@return nil
function CTreasurePool:flush()
end

---@nodiscard
---@param PEntity CBaseEntity?
---@return nil
function CTreasurePool:addMember(PEntity)
end

---@nodiscard
---@param PEntity CBaseEntity?
---@return nil
function CTreasurePool:delMember(PEntity)
end

---@nodiscard
---@param PEntity CBaseEntity?
---@return nil
function CTreasurePool:update(PEntity)
end

---@nodiscard
---@param ItemID integer
---@param PEntity CBaseEntity?
---@return integer
function CTreasurePool:addItem(ItemID, PEntity)
end

---@nodiscard
---@return integer
function CTreasurePool:memberCount()
end

---@nodiscard
---@return table
function CTreasurePool:getMembers()
end

---@nodiscard
---@return table
function CTreasurePool:getItems()
end
