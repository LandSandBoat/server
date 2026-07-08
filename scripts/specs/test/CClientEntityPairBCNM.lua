---@meta

-- luacheck: ignore 241
---@class CClientEntityPairBCNM
local CClientEntityPairBCNM = {}

---@class BcnmKillMobsParams
---@field expectDeath? boolean Whether to expect mobs to die (default: true)
---@field waitForDespawn? boolean Whether to wait for mobs to despawn (default: false)

---Kill all mobs in the current battlefield
---@param params? BcnmKillMobsParams Optional parameters
---@return nil
function CClientEntityPairBCNM:killMobs(params)
end

---@class BcnmExpectWinParams
---@field delayedWin? boolean Whether to delay the win (default: false)
---@field finishOption? integer Event finish option value

---Expect to win the current BCNM
---@param params? BcnmExpectWinParams Optional parameters
---@return nil
function CClientEntityPairBCNM:expectWin(params)
end

---Enter a BCNM via an NPC
---@param npcQuery string|integer|CBaseEntity NPC name, ID, or entity object
---@param bcnmId integer Battlefield ID constant
---@param items? xi.item[] Optional array of item IDs to trade
---@return nil
function CClientEntityPairBCNM:enter(npcQuery, bcnmId, items)
end
