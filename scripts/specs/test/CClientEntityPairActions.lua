---@meta

-- luacheck: ignore 241
---@class CClientEntityPairActions
local CClientEntityPairActions = {}

---Move character
---@param x number
---@param y number
---@param z number
---@return nil
function CClientEntityPairActions:move(x, y, z)
end

---Cast a spell on a target
---@param target CBaseEntity Target entity
---@param spellId xi.magic.spell Spell ID constant (e.g., xi.magic.spell.CURE)
---@return nil
function CClientEntityPairActions:useSpell(target, spellId)
end

---Use a weaponskill on a target
---@param target CBaseEntity Target entity
---@param wsId xi.weaponskill Weaponskill ID
---@return nil
function CClientEntityPairActions:useWeaponskill(target, wsId)
end

---Use a job ability on a target
---@param target CBaseEntity Target entity
---@param abilityId xi.jobAbility Ability ID constant (e.g., xi.jobAbility.PROVOKE)
---@return nil
function CClientEntityPairActions:useAbility(target, abilityId)
end

---Change the current target
---@param target CBaseEntity New target entity
---@return nil
function CClientEntityPairActions:changeTarget(target)
end

---Perform a ranged attack on a target
---@param target CBaseEntity Target entity
---@return nil
function CClientEntityPairActions:rangedAttack(target)
end

---Use an item on a target
---@param target CBaseEntity Target entity
---@param slotId integer Inventory slot ID
---@param storageId? xi.inventoryLocation Storage location (defaults to inventory)
---@return nil
function CClientEntityPairActions:useItem(target, slotId, storageId)
end

---Trigger/interact with a target entity
---@param target CBaseEntity Target entity (usually NPC)
---@param expectedEvent? ExpectedEvent Expected event configuration
---@return nil
function CClientEntityPairActions:trigger(target, expectedEvent)
end

---Invite a player to party
---@param player CBaseEntity Player to invite
---@return nil
function CClientEntityPairActions:inviteToParty(player)
end

---Form an alliance with another party
---@param player CBaseEntity Player from the other party
---@return nil
function CClientEntityPairActions:formAlliance(player)
end

---Accept a pending party invite
---@return nil
function CClientEntityPairActions:acceptPartyInvite()
end

---@class TradeItem
---@field itemId xi.item Item ID
---@field quantity? integer Quantity (default: 1)

---Trade items to an NPC
---@param npcQuery string|integer|CBaseEntity NPC name, ID, or entity object
---@param items (xi.item|TradeItem)[] Array of item IDs or TradeItem tables
---@param expectedEvent? ExpectedEvent Expected event configuration
---@return nil
function CClientEntityPairActions:tradeNpc(npcQuery, items, expectedEvent)
end
