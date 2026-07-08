xi = xi or {}

-- Check Lua item with:
-- local isEx = bit.band(item:getFlag(), xi.itemFlag.EXCLUSIVE) ~= 0
---@enum xi.itemFlag
xi.itemFlag =
{
    AUG_SENDABLE    = 0x00001, -- Can be sent even with augments
    GM_ONLY         = 0x00002, -- Can only be obtained/used by GMs
    MYSTERY_BOX     = 0x00004, -- Can be gained from Gobbie Mystery Box
    MOG_GARDEN      = 0x00008, -- Can use in Mog Garden
    CAN_SEND_ACCT   = 0x00010, -- Can send to characters on same account
    INSCRIBABLE     = 0x00020, -- Can be signed during synthesis
    NO_AUCTION      = 0x00040, -- Cannot be placed on the Auction House
    SCROLL          = 0x00080,
    LINKSHELL       = 0x00100, -- Linkshell type items
    CAN_USE         = 0x00200, -- Can use the item
    CAN_TRADE_NPC   = 0x00400, -- Can trade the item to NPCs
    CAN_EQUIP       = 0x00800, -- Can be equipped
    NO_SALE         = 0x01000, -- Cannot be sold to vendors
    NO_DELIVERY     = 0x02000, -- Cannot be sent through the PBX
    EXCLUSIVE       = 0x04000, -- Cannot be traded to another PC
    RARE            = 0x08000, -- Cannot own multiple copies
    NO_RECYCLE      = 0x10000, -- Item skips Recycle Bin
    NO_RARE_CHECK   = 0x20000, -- Item skips Rare check in Treasure Pool
}
