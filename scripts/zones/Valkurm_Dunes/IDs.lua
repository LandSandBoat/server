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
        ITEM_CANNOT_BE_OBTAINED        = 6408,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                  = 6416,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6417,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6419,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6420,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY        = 6430,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET          = 6445,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS            = 7027,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 7028,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                   = 7029,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED  = 7049,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                  = 7094,  -- Tallying conquest results...
        REGION_POINTS_SANDORIA         = 7159,  -- San d'Oria's region points have increased!
        EXP_FORCE_KILL_SANDORIA        = 7162,  -- San d'Orian E.F. defeats beastmen hordes... Maintain current momentum.
        BEASTMEN_BANNER_CURSE          = 7173,  -- There was a curse on the beastmen's banner!
        BEASTMEN_BANNER_LIFTED         = 7174,  -- The curse of the beastmen's banner has been lifted!
        BEASTMEN_BANNER                = 7175,  -- There is a beastmen's banner.
        FISHING_MESSAGE_OFFSET         = 7253,  -- You can't fish here.
        DIG_THROW_AWAY                 = 7266,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                   = 7268,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET             = 7334,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        FOUND_ITEM_WITH_EASE           = 7343,  -- It appears your chocobo found this item with ease.
        SONG_RUNES_DEFAULT             = 7354,  -- Lyrics on the old monument sing the story of lovers torn apart.
        UNLOCK_BARD                    = 7375,  -- You can now become a bard!
        JUST_A_PILE_OF_SAND            = 7376,  -- Just a pile of sand.
        SIGNPOST2                      = 7383,  -- Northeast: La Theine Plateau Southeast: Konschtat Highlands West: Selbina
        SIGNPOST1                      = 7384,  -- Northeast: La Theine Plateau Southeast: Konschtat Highlands Southwest: Selbina
        CONQUEST                       = 7394,  -- You've earned conquest points!
        FOUL_PRESENCE                  = 7728,  -- You sense a foul presence.
        YOU_SENSE_AN_EVIL_PRESENCE     = 7738,  -- You sense an evil presence...
        MUST_BE_CLOSER                 = 7739,  -- You must be closer to the spot in order to thrust the <keyitem> in.
        WHAT_DO_YOU_THINK              = 7740,  -- What do you think you are doing!?
        SUDDEN_CHILL                   = 7742,  -- You feel a sudden chill in the air.
        AN_EMPTY_LIGHT_SWIRLS          = 7772,  -- An empty light swirls about the cave, eating away at the surroundings...
        GARRISON_BASE                  = 7774,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        TIME_ELAPSED                   = 7821,  -- Time elapsed: <number> [hour/hours] (Vana'diel time) <number> [minute/minutes] and <number> [second/seconds] (Earth time)
        RETURN_TO_SEA                  = 7825,  -- You return the <item> to the sea.
        TOO_MANY_IN_PARTY              = 7845,  -- Nothing happens. Your party exceeds the maximum number of <number> members.
        ALLIANCE_NOT_ALLOWED           = 7846,  -- Nothing happens. You must dissolve your alliance.
        MONSTERS_KILLED_ADVENTURERS    = 7848,  -- Long ago, monsters killed many adventurers and merchants just off the coast here. If you find any vestige of the victims and return it to the sea, perhaps it would appease the spirits of the dead.
        RIGHT_OVER_THERE_POINT         = 7853,  -- Right over there! The ship-shape-shimmery point!
        NO_LONGER_FEEL_CHILL           = 7863,  -- You no longer feel a chill. The chart may lose its power if you venture too far.
        TOO_MUCH_TIME_PASSED           = 7864,  -- Too much time has passed. The monster has lost interest.
        YOU_CANNOT_ENTER_DYNAMIS       = 7886,  -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 7888,  -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 8010,  -- There is a strange symbol drawn here. A haunting chill sweeps through you as you gaze upon it...
        PLAYER_OBTAINS_ITEM            = 8098,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM          = 8099,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM       = 8100,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP           = 8101,  -- You already possess that temporary item.
        NO_COMBINATION                 = 8106,  -- You were unable to enter a combination.
        UNITY_WANTED_BATTLE_INTERACT   = 8168,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED              = 10284, -- New training regime registered!
        COMMON_SENSE_SURVIVAL          = 12338, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },

    mob =
    {
        BEACH_MONK             = GetFirstID('Beach_Monk'),
        DOMAN                  = GetFirstID('Doman'),
        GOLDEN_BAT             = GetFirstID('Golden_Bat'),
        HALFORC_BLACK_MAGE     = GetFirstID('Halforc_Black_Mage'),
        HALFORC_DARK_KNIGHT    = GetFirstID('Halforc_Dark_Knight'),
        HALFORC_DRAGOON        = GetFirstID('Halforc_Dragoon'),
        HALFORC_MONK           = GetFirstID('Halforc_Monk'),
        HALFORC_PALADIN        = GetFirstID('Halforc_Paladin'),
        HALFORC_RANGER         = GetFirstID('Halforc_Ranger'),
        HALFORC_WARRIOR        = GetFirstID('Halforc_Warrior'),
        HEIKE_CRAB             = GetFirstID('Heike_Crab'),
        HOBGOBLIN_BEASTMASTER  = GetFirstID('Hobgoblin_Beastmaster'),
        HOBGOBLIN_BLACK_MAGE   = GetFirstID('Hobgoblin_Black_Mage'),
        HOBGOBLIN_DARK_KNIGHT  = GetFirstID('Hobgoblin_Dark_Knight'),
        HOBGOBLIN_RANGER       = GetFirstID('Hobgoblin_Ranger'),
        HOBGOBLIN_RED_MAGE     = GetFirstID('Hobgoblin_Red_Mage'),
        HOBGOBLIN_THIEF        = GetFirstID('Hobgoblin_Thief'),
        HOBGOBLIN_WARRIOR      = GetFirstID('Hobgoblin_Warrior'),
        HOBGOBLIN_WHITE_MAGE   = GetFirstID('Hobgoblin_White_Mage'),
        HOUU_THE_SHOALWADER    = GetFirstID('Houu_the_Shoalwader'),
        MARCHELUTE             = GetFirstID('Marchelute'),
        METAQUADAV_BLACK_MAGE  = GetFirstID('Metaquadav_Black_Mage'),
        METAQUADAV_DARK_KNIGHT = GetFirstID('Metaquadav_Dark_Knight'),
        METAQUADAV_PALADIN     = GetFirstID('Metaquadav_Paladin'),
        METAQUADAV_RED_MAGE    = GetFirstID('Metaquadav_Red_Mage'),
        METAQUADAV_THIEF       = GetFirstID('Metaquadav_Thief'),
        METAQUADAV_WARRIOR     = GetFirstID('Metaquadav_Warrior'),
        METAQUADAV_WHITE_MAGE  = GetFirstID('Metaquadav_White_Mage'),
        ONRYO                  = GetFirstID('Onryo'),
        VALKURM_EMPEROR        = GetFirstID('Valkurm_Emperor'),
    },

    npc =
    {
        BARNACLED_BOX     = GetFirstID('Barnacled_Box'),
        BEASTMENS_BANNER  = GetFirstID('Beastmens_Banner'),
        OVERSEER_BASE     = GetFirstID('Quanteilleron_RK'),
        PIRATE_CHART_QM   = GetFirstID('qm4'),
        PIRATE_CHART_TARU = GetFirstID('Pirate_Chart_Taru'),
        SHIMMERING_POINT  = GetFirstID('Shimmering_Point'),
        SUNSAND_QM        = GetFirstID('qm1'),
        WHM_AF1_QM        = GetFirstID('qm2')
    },
}

return zones[xi.zone.VALKURM_DUNES]
