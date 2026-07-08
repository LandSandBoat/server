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

---Populate the player's BLU spell page from a list of spell IDs
---@param spellIds xi.magic.spell[] List of BLU spell IDs to set
---@return nil
function CClientEntityPairActions:setBlueSpells(spellIds)
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

---Request a trade with another player.
---@param target CBaseEntity Trade target
---@return nil
function CClientEntityPairActions:tradeRequest(target)
end

---Accept the incoming trade request.
---@return nil
function CClientEntityPairActions:tradeAccept()
end

---Place an item in a trade slot.
---@param tradeIndex integer Trade slot, 0..8
---@param invSlot integer Inventory slot of the source item
---@param itemId xi.item Item ID
---@param quantity integer Amount
---@return nil
function CClientEntityPairActions:tradeOffer(tradeIndex, invSlot, itemId, quantity)
end

---Clear a trade slot.
---@param tradeIndex integer Trade slot, 0..8
---@return nil
function CClientEntityPairActions:tradeClearSlot(tradeIndex)
end

---Lock in this side's offer. Trade goes through once both sides lock.
---@return nil
function CClientEntityPairActions:tradeMake()
end

---Cancel the trade.
---@return nil
function CClientEntityPairActions:tradeCancel()
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

---Buy an item from a guild shop
---@param itemId xi.item Item ID
---@param quantity integer Amount to buy
---@return nil
function CClientEntityPairActions:guildBuy(itemId, quantity)
end

---Sell an item to a guild shop
---@param itemId xi.item Item ID
---@param quantity integer Amount to sell
---@return nil
function CClientEntityPairActions:guildSell(itemId, quantity)
end

---@class GuildListEntry
---@field count integer Current stock
---@field max integer Max stock
---@field price integer Buy or sell price

---Request a guild shop's buy list and return it decoded
---@nodiscard
---@return table<integer, GuildListEntry> list Entries keyed by item ID
function CClientEntityPairActions:guildBuyList()
end

---Request a guild shop's sell list and return it decoded
---@nodiscard
---@return table<integer, GuildListEntry> list Entries keyed by item ID
function CClientEntityPairActions:guildSellList()
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

---Sow a seed or feed a crystal to a gardening pot. Pot and add item must be in a mog safe.
---@param potContainer xi.inventoryLocation Container holding the flowerpot
---@param potSlot integer Flowerpot slot index
---@param addContainer xi.inventoryLocation Container holding the seed or crystal
---@param addSlot integer Seed or crystal slot index
---@return nil
function CClientEntityPairActions:plantAdd(potContainer, potSlot, addContainer, addSlot)
end

---Examine a plant; resets its wilt timer.
---@param potContainer xi.inventoryLocation Container holding the flowerpot
---@param potSlot integer Flowerpot slot index
---@return nil
function CClientEntityPairActions:plantCheck(potContainer, potSlot)
end

---Harvest a mature plant; uproot clears the pot instead.
---@param potContainer xi.inventoryLocation Container holding the flowerpot
---@param potSlot integer Flowerpot slot index
---@param uproot? boolean Uproot instead of harvesting (default false)
---@return nil
function CClientEntityPairActions:plantHarvest(potContainer, potSlot, uproot)
end

---Dry a plant so it stops growing and won't wilt.
---@param potContainer xi.inventoryLocation Container holding the flowerpot
---@param potSlot integer Flowerpot slot index
---@return nil
function CClientEntityPairActions:plantDry(potContainer, potSlot)
end

---Install a furnishing on the 1st floor at grid cell (x, z).
---@param container xi.inventoryLocation Container holding the furnishing
---@param slot integer Furnishing slot index
---@param x integer Grid x cell
---@param z integer Grid z cell
---@return nil
function CClientEntityPairActions:placeFurniture(container, slot, x, z)
end

---Finish placing furniture; recomputes the active moghancement.
---@return nil
function CClientEntityPairActions:finishFurnishing()
end
