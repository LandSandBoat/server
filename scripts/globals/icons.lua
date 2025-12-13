-----------------------------------
-- Name Icons
--
-- These codes can be inserted into entity names to display various icons.
--
-- See `test_npcs_in_gm_home.lua` for an example of usage.
-- Both string.format() and concatenation work for building up the new name.
--
-- You can use the following to rename an entity to include an icon:
-- entity:renameEntity(xi.icon.SQUARE .. 'Bob')
--
-- This is compatible with !exec:
-- !exec target:renameEntity(xi.icon.SQUARE .. 'Bob')
--
-- Notes:
-- You can do as many icons as you want that will fit in the buffer, but the game will intentionally make the second and any following icons smaller.
-- Some icons are also enabled to be full-size when used as a suffix, such as the same sword and shield icon (icon 0xA9).
-----------------------------------

xi = xi or {}
xi.icon = xi.icon or {}

xi.icon =
{
    SQUARE                      = string.char(0x81), -- Symbol: Square
    X                           = string.char(0x82), -- Symbol: X
    COPYRIGHT                   = string.char(0x83), -- Symbol: Copyright
    SUPERSCRIPT_1               = string.char(0x84), -- Symbol: 1 Superscript
    SUPERSCRIPT_2               = string.char(0x85), -- Symbol: 2 Superscript
    SUPERSCRIPT_3               = string.char(0x86), -- Symbol: 3 Superscript
    SUPERSCRIPT_4               = string.char(0x87), -- Symbol: 4 Superscript
    SUPERSCRIPT_5               = string.char(0x88), -- Symbol: 5 Superscript
    SUPERSCRIPT_6               = string.char(0x89), -- Symbol: 6 Superscript
    SUPERSCRIPT_7               = string.char(0x8A), -- Symbol: 7 Superscript
    SUPERSCRIPT_8               = string.char(0x8B), -- Symbol: 8 Superscript
    ELLIPSIS                    = string.char(0x8C), -- Symbol: Ellipsis
    SUPERSCRIPT_9               = string.char(0x8D), -- Symbol: 9 Superscript
    PLAYONLINE_1                = string.char(0x8E), -- Icon: PlayOnline
    DISCONNECTING               = string.char(0x8F), -- Icon: Disconnecting (R0)
    AWAY                        = string.char(0x90), -- Icon: Away
    SEEKING_PARTY               = string.char(0x91), -- Icon: Seeking Party
    LINK_PEARL                  = string.char(0x92), -- Icon: Link Pearl
    TRIAL_PLAYER                = string.char(0x93), -- Icon: Trial Player (Green and Yellow Arrow)
    SWORD                       = string.char(0x94), -- Icon: Sword
    PLAYONLINE_2                = string.char(0x95), -- Icon: PlayOnline
    GM_1                        = string.char(0x96), -- Icon: GM
    GM_2                        = string.char(0x97), -- Icon: GM
    GM_3                        = string.char(0x98), -- Icon: GM
    SQUARE_ENIX                 = string.char(0x99), -- Icon: Square Enix
    TREASURE_CHEST              = string.char(0x9A), -- Icon: Treasure Chest
    EXCHANGE                    = string.char(0x9B), -- Icon: Exchange (Hands)
    BAZAAR                      = string.char(0x9C), -- Icon: Bazaar
    SEEKING_PARTY_AUTO          = string.char(0x9D), -- Icon: Seeking Party (Auto-Party)
    BALLISTA_FLAG_SANDORIA      = string.char(0x9E), -- Icon: Ballista Flag - San d'Oria
    BALLISTA_FLAG_BASTOK        = string.char(0x9F), -- Icon: Ballista Flag - Bastok
    BALLISTA_FLAG_WINDURST      = string.char(0xA0), -- Icon: Ballista Flag - Windurst
    NEW_ADVENTURER              = string.char(0xA1), -- Icon: New Adventurer (Red ?)
    MENTOR                      = string.char(0xA2), -- Icon: Mentor
    BALLISTA_FLAG_WYVERN_CREST  = string.char(0xA3), -- Icon: Ballista Flag - Wyvern Crest (Blue)
    BALLISTA_FLAG_GRIFFON_CREST = string.char(0xA4), -- Icon: Ballista Flag - Griffon Crest (Green)
    BALLISTA_ICON_FLAMME        = string.char(0xA5), -- Icon: Ballista Icon - Flamme (Red Rock)
    PANKRATION_FLAG_RED         = string.char(0xA6), -- Icon: Pankration Flag - Red
    PANKRATION_FLAG_BLUE        = string.char(0xA7), -- Icon: Pankration Flag - Blue
    LEVEL_SYNC                  = string.char(0xA8), -- Icon: Level Sync
    SWORD_AND_SHIELD            = string.char(0xA9), -- Icon: Sword and Shield
    STAR_LARGE                  = string.char(0xAA), -- Icon: Star (Large)
    MONSTROSITY                 = string.char(0xAB), -- Icon: Monstrosity
    SEEKING_PARTY_MASTERY       = string.char(0xAC), -- Icon: Seeking Party (Mastery)
    STAR_SMALL                  = string.char(0xAD), -- Icon: Star (Small)
    UNKNOWN_PINK_LEAF           = string.char(0xAE), -- Icon: Unknown (Pink Leaf)
    SNOWFLAKE                   = string.char(0xAF), -- Icon: Snowflake
    MOON                        = string.char(0xB0), -- Icon: Moon
    INFORMATION_ICON            = string.char(0xB1), -- Icon: Information Icon (Blue circle with white i.)
}
