---@meta

-- luacheck: ignore 241
---@class CClientEntityPairActions
local CClientEntityPairActions = {}

---Move character
---@param x number
---@param y number
---@param z number
---@param rot number?
---@return nil
function CClientEntityPairActions:move(x, y, z, rot)
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

---Accept raise prompt
---@return nil
function CClientEntityPairActions:acceptRaise()
end

---Move to, face and engage entity.
---@param mob CBaseEntity Monster to engage
---@return nil
function CClientEntityPairActions:engage(mob)
end

---Perform a skillchain sequence on a target
---@param target CBaseEntity Target entity
---@param ... xi.weaponskill Weaponskill IDs to chain (requires at least 2)
---@return nil
function CClientEntityPairActions:skillchain(target, ...)
end

---Move an item between containers or split a stack
---@param srcContainer xi.inventoryLocation Source container
---@param srcSlot integer Source slot index
---@param dstContainer xi.inventoryLocation Destination container
---@param quantity integer Quantity to move
---@param dstSlot? integer Destination slot (omit for first free)
---@return nil
function CClientEntityPairActions:moveItem(srcContainer, srcSlot, dstContainer, quantity, dstSlot)
end

---Sort a container, merging partial stacks
---@param container xi.inventoryLocation Container to sort
---@return nil
function CClientEntityPairActions:sortContainer(container)
end

---Drop an item (sends to recycle bin if enabled)
---@param container xi.inventoryLocation Source container
---@param slot integer Slot index
---@param quantity integer Quantity to drop
---@return nil
function CClientEntityPairActions:dropItem(container, slot, quantity)
end

---@class LockstyleItem
---@field itemId integer Item ID
---@field slot xi.slot Equipment slot

---Set lockstyle mode, optionally with item overrides
---@param mode integer Lockstyle mode (0=disable, 3=set, 4=enable)
---@param items? LockstyleItem[] Items to apply
---@return nil
function CClientEntityPairActions:setLockstyle(mode, items)
end

---Start a synthesis. Inventory slots are resolved automatically.
---@param crystal xi.item Crystal item ID
---@param ingredients xi.item[] Ingredient item IDs (1..8)
---@return nil
function CClientEntityPairActions:craft(crystal, ingredients)
end
