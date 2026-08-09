-----------------------------------
-- Flags during events
-----------------------------------
xi = xi or {}

-- Note: events have opcodes that can set flags internally, these can be ignored or set for each unique cutscene.
---@enum xi.cutsceneFlag
xi.cutsceneFlag =
{
    RESET_CAMERA        = 0x00000001, -- On end: restore player pos from server pos, reset camera behind player
    NO_PCS              = 0x00000002, -- Do not display Player Characters not in the event
    SEND_POSITION       = 0x00000004, -- Keep tracking/sending player position while the event moves them
    UNKNOWN_0008        = 0x00000008, -- Unknown usage. Often set but the client doesn't use it.
    NO_NPCS             = 0x00000010, -- Do not display NPCs and Mobs not in the event
    NO_PARTICIPANT_ANIM = 0x00000020, -- Drop scheduler packets whose caster or target is in the event
    NO_DIALOGUE         = 0x00000040, -- Suppress server chat/dialogue text (TalkNum family)
    OPENING_MODE        = 0x00000080, -- Zone-in only: opening cutscene mode
    NO_IDLE_WAIT        = 0x00000100, -- Start immediately, skip the "actors must be idle/unlocked" gate
    KEEP_ACTOR_COLOR    = 0x00000200, -- Don't reset actor color to 0x80808080 on event start
    NO_BATTLE_ANIM      = 0x00000400, -- Drop battle actions where caster or target is in the event
    NO_MAGIC_ANIM       = 0x00000800, -- Drop all scheduler packets for the whole event
    ALLOW_OWN_ACTION    = 0x00001000, -- Let your own action animations play
    IGNORE_UNLOCK       = 0x00002000, -- Ignore the server's event-unlock message (possibly unused - client forces it)
    UNUSED_4000         = 0x00004000, -- Never read by the client
    GROUND_SNAP_ON_END  = 0x00008000, -- Re-seat actors onto the terrain when the event ends
    HIDE_TARGET_WINDOW  = 0x00010000, -- Suppresses the "targetwi" HUD window for the event
}
