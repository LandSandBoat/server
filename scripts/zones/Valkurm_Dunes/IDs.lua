-----------------------------------
-- Area: Valkurm_Dunes
-----------------------------------
zones = zones or {}

zones[xi.zone.VALKURM_DUNES] =
{
    text =
    {
        MOG_TABLET_BASE                = 22,    -- A mog tablet has been discovered in [West Ronfaure/East Ronfaure/the La Theine Plateau/the Valkurm Dunes/Jugner Forest/the Batallia Downs/North Gustaberg/South Gustaberg/the Konschtat Highlands/the Pashhow Marshlands/the Rolanberry Fields/Beaucedine Glacier/Xarcabard/West Sarutabaruta/East Sarutabaruta/the Tahrongi Canyon/the Buburimu Peninsula/the Meriphataud Mountains/the Sauromugue Champaign/Qufim Island/Behemoth's Dominion/Cape Teriggan/the Eastern Altepa Desert/the Sanctuary of Zi'Tah/Ro'Maeve/the Yuhtunga Jungle/the Yhoator Jungle/the Western Altepa Desert/the Valley of Sorrows]!
        NOTHING_HAPPENS                = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED        = 6406,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                  = 6412,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6413,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6415,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6416,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY        = 6426,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET          = 6441,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS            = 7023,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 7024,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                   = 7025,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED  = 7045,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                  = 7087,  -- Tallying conquest results...
        BEASTMEN_BANNER                = 7168,  -- There is a beastmen's banner.
        FISHING_MESSAGE_OFFSET         = 7246,  -- You can't fish here.
        DIG_THROW_AWAY                 = 7259,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                   = 7261,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET             = 7327,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        FOUND_ITEM_WITH_EASE           = 7336,  -- It appears your chocobo found this item with ease.
        SONG_RUNES_DEFAULT             = 7346,  -- Lyrics on the old monument sing the story of lovers torn apart.
        UNLOCK_BARD                    = 7367,  -- You can now become a bard!
        JUST_A_PILE_OF_SAND            = 7368,  -- Just a pile of sand.
        SIGNPOST2                      = 7375,  -- Northeast: La Theine Plateau Southeast: Konschtat Highlands West: Selbina
        SIGNPOST1                      = 7376,  -- Northeast: La Theine Plateau Southeast: Konschtat Highlands Southwest: Selbina
        CONQUEST                       = 7386,  -- You've earned conquest points!
        YOU_SENSE_AN_EVIL_PRESENCE     = 7730,  -- You sense an evil presence...
        WHAT_DO_YOU_THINK              = 7732,  -- What do you think you are doing!?
        AN_EMPTY_LIGHT_SWIRLS          = 7764,  -- An empty light swirls about the cave, eating away at the surroundings...
        GARRISON_BASE                  = 7766,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        TIME_ELAPSED                   = 7813,  -- Time Elapsed: / [hour/hours] (Vanadiel Time) / [minute/minutes] and [second/seconds] (Earth time)
        MONSTERS_KILLED_ADVENTURERS    = 7840,  -- Long ago, monsters killed many adventurers and merchants just off the coast here. If you find any vestige of the victims and return it to the sea, perhaps it would appease the spirits of the dead.
        YOU_CANNOT_ENTER_DYNAMIS       = 7878,  -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 7880,  -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 8002,  -- There is a strange symbol drawn here. A haunting chill sweeps through you as you gaze upon it...
        PLAYER_OBTAINS_ITEM            = 8090,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM          = 8091,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM       = 8092,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP           = 8093,  -- You already possess that temporary item.
        NO_COMBINATION                 = 8098,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT   = 8160,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED              = 10276, -- New training regime registered!
        COMMON_SENSE_SURVIVAL          = 12330, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        VALKURM_EMPEROR = GetFirstID('Valkurm_Emperor'),
        GOLDEN_BAT      = GetFirstID('Golden_Bat'),
        MARCHELUTE      = GetFirstID('Marchelute'),
        DOMAN           = GetFirstID('Doman'),
        ONRYO           = GetFirstID('Onryo'),
    },
    npc =
    {
        SUNSAND_QM    = GetFirstID('qm1'),
        OVERSEER_BASE = GetFirstID('Quanteilleron_RK'),
    },
}

return zones[xi.zone.VALKURM_DUNES]
