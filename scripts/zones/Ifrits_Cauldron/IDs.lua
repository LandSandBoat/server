-----------------------------------
-- Area: Ifrits_Cauldron
-----------------------------------
zones = zones or {}

zones[xi.zone.IFRITS_CAULDRON] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6390,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6394,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6395,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397,  -- Obtained key item: <keyitem>.
        ITEMS_OBTAINED                = 6403,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6408,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6423,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7005,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7072,  -- Tallying conquest results...
        REGION_POINTS_SANDORIA        = 7137,  -- San d'Oria's region points have increased!
        ALTAR_COMPLETED               = 7261,  -- You have already made an offering today.
        ALTAR_INSPECT                 = 7262,  -- This looks like the altar where offerings are to be placed.
        ALTAR_OFFERING                = 7263,  -- You place your offering of <item> on the altar.
        ALTAR_STANDARD                = 7264,  -- It is an altar for offerings.
        CHEST_UNLOCKED                = 7273,  -- You unlock the chest!
        MINING_IS_POSSIBLE_HERE       = 7281,  -- Mining is possible here if you have <item>.
        BAD_FEELING_ABOUT_PLACE       = 7288,  -- You have a bad feeling about this place.
        LAVA_FLOWS_SLOWLY             = 7289,  -- Lava flows slowly through the rocks.
        EGGSHELLS_LIE_SCATTERED       = 7290,  -- Eggshells lie scattered around the place...
        SENSE_OMINOUS_PRESENCE        = 7293,  -- You sense an ominous presence...
        REGIME_REGISTERED             = 10445, -- New training regime registered!
        PLAYER_OBTAINS_ITEM           = 11497, -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 11498, -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 11499, -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 11500, -- You already possess that temporary item.
        NO_COMBINATION                = 11505, -- You were unable to enter a combination.
        HOMEPOINT_SET                 = 11531, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 11589, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        COMMON_SENSE_SURVIVAL         = 11611, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        TYRANNIC_TUNNOK  = GetFirstID('Tyrannic_Tunnok'),
        LINDWURM         = GetFirstID('Lindwurm'),
        FORESEER_ORAMIX  = GetFirstID('Foreseer_Oramix'),
        VOUIVRE          = GetFirstID('Vouivre'),
        PIRATES_COVE_NMS = GetFirstID('Salamander'),
        ASH_DRAGON       = GetFirstID('Ash_Dragon'),
        MIMIC            = GetFirstID('Mimic'),
        BOMB_QUEEN       = GetFirstID('Bomb_Queen'),
        TARASQUE         = GetFirstID('Tarasque'),
        CAILLEACH_BHEUR  = GetFirstID('Cailleach_Bheur'),
    },
    npc =
    {
        FLAME_SPOUT_OFFSET = GetFirstID('Flame_Spout'),
        TREASURE_COFFER    = GetFirstID('Treasure_Coffer'),
        MINING             = GetTableOfIDs('Mining_Point'),
    },
}

return zones[xi.zone.IFRITS_CAULDRON]
