-----------------------------------
-- This file holds all global (not zone specific) text references
-----------------------------------
xi = xi or {}
xi.msg = xi.msg or {}

-----------------------------------
-- Message Channels
-----------------------------------

---@enum xi.channel
xi.msg.channel =
{
    SAY           = 0,
    SHOUT         = 1,
    TELL          = 3,
    PARTY         = 4,
    LINKSHELL     = 5,
    SYSTEM_1      = 6, -- Standard "printToPlayer" default if no type specified
    SYSTEM_2      = 7, -- Login / world announcement messages
    EMOTION       = 8,
    -- 9 / 10 / 11 = Does not work / nothing
    GM_PROMPT     = 12, -- Menu prompt from GM
    NS_SAY        = 13, -- NS = "No speaker object displayed", otherwise same as SAY
    NS_SHOUT      = 14, -- NS = "No speaker object displayed", otherwise same as SHOUT
    NS_PARTY      = 15, -- NS = "No speaker object displayed", otherwise same as PARTY
    NS_LINKSHELL  = 16, -- NS = "No speaker object displayed", otherwise same as LINKSHELL
    UNKNOWN_17    = 17, -- 17 through 25 appear to repeat the effects of other values
    UNKNOWN_18    = 18,
    UNKNOWN_19    = 19,
    UNKNOWN_20    = 20,
    UNKNOWN_21    = 21,
    UNKNOWN_22    = 22,
    UNKNOWN_23    = 23,
    UNKNOWN_24    = 24,
    UNKNOWN_25    = 25,
    YELL          = 26,
    LINKSHELL2    = 27, -- Second LS color. Default is Green
    NS_LINKSHELL2 = 28, -- NS = "No speaker object displayed", otherwise same as LINKSHELL2
    SYSTEM_3      = 29, -- "Basic system messages" in config menu. Yellow by default.
    LINKSHELL3    = 30, -- Yes really it looks like a 3rd LS may have been planned at some point.
    NS_LINKSHELL3 = 31, -- (assumed as it follows pattern and color)
    UNKNOWN_32    = 32, -- Looks the same as 31
    UNITY         = 33,
    JP_ASSIST     = 34,
    NA_ASSIST     = 35,
}

-- used by player:printToArea
---@enum xi.area
xi.msg.area =
{
    SYSTEM = 0, -- Server wide like the purple stuff :)
    SAY    = 1, -- Will display in small area around player
    SHOUT  = 2, -- Will display in wide area around player
    PARTY  = 3, -- Will display to players entire party/alliance
    YELL   = 4, -- If yell is enabled in zone, will display.
    UNITY  = 5, -- Also World Wide
}

-- Used to modify certain basic messages.
---@enum xi.actionModifier
xi.msg.actionModifier =
{
    NONE        = 0x00,
    COVER       = 0x01,
    RESIST      = 0x02, -- Resist! <Regular message> -- Used for resist traits triggers.
    MAGIC_BURST = 0x04, -- Currently known to be used for Swipe/Lunge only
    IMMUNOBREAK = 0x08,
}

-----------------------------------
-- System Messages
-----------------------------------

---@enum xi.system
xi.msg.system =
{
    GLOBAL_TRUST_OFFSET          = 0,
    EXECUTING_LOGOUT             = 7,   -- Executing logout in <seconds> seconds. Cancel healing to remain logged in.
    OBTAINS_GIL                  = 19,  -- Treasure pool message ala 0x0D2 `Gold` value of non- zero "<Name> obtains <value> gil."
    EXECUTING_SHUTDOWN           = 35,  -- Executing shutdown in <seconds> seconds. Cancel healing to remain logged in.
    WAIT_LONGER                  = 38,  -- You must wait longer to perform that action.
    TRUST_NO_SEEKING_PARTY       = 296, -- You cannot use Trust magic while seeking a party.
    TRUST_DELAY_NEW_PARTY_MEMBER = 297, -- While inviting a party member, you must wait a while before using Trust magic.
    TRUST_MAXIMUM_NUMBER         = 298, -- You have called forth your maximum number of alter egos.
    TRUST_ALREADY_CALLED         = 299, -- That alter ego has already been called forth.
    TRUST_NO_ENMITY              = 300, -- You cannot use Trust magic while having gained enmity.
    TRUST_SOLO_OR_LEADER         = 301, -- You cannot use Trust magic unless you are solo or the party leader.
}
