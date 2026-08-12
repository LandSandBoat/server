-----------------------------------
-- Area: Xarcabard
-----------------------------------
zones = zones or {}

zones[xi.zone.XARCABARD] =
{
    text =
    {
        NOTHING_HAPPENS                = 119,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED        = 6400,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                  = 6408,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6409,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6411,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6412,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY        = 6422,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET          = 6437,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS            = 7019,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 7020,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                   = 7021,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED  = 7041,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                  = 7086,  -- Tallying conquest results...
        REGION_POINTS_SANDORIA         = 7151,  -- San d'Oria's region points have increased!
        EXP_FORCE_KILL_SANDORIA        = 7154,  -- San d'Orian E.F. defeats beastmen hordes... Maintain current momentum.
        BEASTMEN_BANNER_CURSE          = 7165,  -- There was a curse on the beastmen's banner!
        BEASTMEN_BANNER_LIFTED         = 7166,  -- The curse of the beastmen's banner has been lifted!
        BEASTMEN_BANNER                = 7167,  -- There is a beastmen's banner.
        PRESENCE_IN_CAVE               = 7246,  -- You sense a presence in the cave...
        MONSTER_APPEARS                = 7249,  -- A monster appears from deep within the cave!
        SENSE_EVIL                     = 7375,  -- You can sense an evil force around you.
        DO_NOT_SENSE                   = 7376,  -- You do not sense anything out of the ordinary.
        ALREADY_OBTAINED_TELE          = 7396,  -- You already possess the gate crystal for this telepoint.
        CONQUEST                       = 7409,  -- You've earned conquest points!
        ONLY_SHARDS                    = 7742,  -- Only shards of ice lie upon the ground.
        BLOCKS_OF_ICE                  = 7743,  -- You can hear blocks of ice moving from deep within the cave.
        PERENNIAL_SNOW_DEFAULT         = 7744,  -- How many millennia has this snow been here, hidden from the rays of the sun?
        PERENNIAL_SNOW_WAIT            = 7746,  -- The <keyitem> you buried is not yet purified.
        CAVERN_CONTINUES               = 7801,  -- The cavern continues on for quite a distance.
        NOTHING_MORE                   = 7802,  -- There is nothing more to be done here.
        SOMETHING_BURIED               = 7830,  -- It looks like something was buried here.
        YOU_CANNOT_ENTER_DYNAMIS       = 7868,  -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 7870,  -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 7907,  -- There is a symbol carved into the rock here.
        GARRISON_BASE                  = 8062,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        PLAYER_OBTAINS_ITEM            = 8185,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM          = 8186,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM       = 8187,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP           = 8188,  -- You already possess that temporary item.
        NO_COMBINATION                 = 8193,  -- You were unable to enter a combination.
        VOIDWALKER_DESPAWN             = 8224,  -- The monster fades before your eyes, a look of disappointment on its face.
        UNITY_WANTED_BATTLE_INTERACT   = 8255,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED              = 10371, -- New training regime registered!
        VOIDWALKER_NO_MOB              = 11490, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR         = 11491, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT            = 11492, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB           = 11493, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1        = 11495, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2        = 11496, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI            = 11497, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI           = 11498, -- Obtained key item: <keyitem>!
        LEARNS_SPELL                   = 11547, -- <name> learns <spell>!
        UNCANNY_SENSATION              = 11549, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL          = 11556, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BARBARIC_WEAPON       = GetFirstID('Barbaric_Weapon'),
        BOREAL_COEURL         = GetFirstID('Boreal_Coeurl'),
        BOREAL_HOUND          = GetFirstID('Boreal_Hound'),
        BOREAL_TIGER          = GetFirstID('Boreal_Tiger'),
        CHAOS_ELEMENTAL       = GetFirstID('Chaos_Elemental'),
        ERESHKIGAL            = GetFirstID('Ereshkigal'),
        GIGAS_BEASTMASTER     = GetFirstID('Gigas_Beastmaster'),
        GIGAS_MONK            = GetFirstID('Gigas_Monk'),
        GIGAS_RANGER          = GetFirstID('Gigas_Ranger'),
        GIGAS_WARRIOR         = GetFirstID('Gigas_Warrior'),
        HOBGOBLIN_BEASTMASTER = GetFirstID('Hobgoblin_Beastmaster'),
        HOBGOBLIN_BLACK_MAGE  = GetFirstID('Hobgoblin_Black_Mage'),
        HOBGOBLIN_DARK_KNIGHT = GetFirstID('Hobgoblin_Dark_Knight'),
        HOBGOBLIN_RANGER      = GetFirstID('Hobgoblin_Ranger'),
        HOBGOBLIN_RED_MAGE    = GetFirstID('Hobgoblin_Red_Mage'),
        HOBGOBLIN_THIEF       = GetFirstID('Hobgoblin_Thief'),
        HOBGOBLIN_WARRIOR     = GetFirstID('Hobgoblin_Warrior'),
        HOBGOBLIN_WHITE_MAGE  = GetFirstID('Hobgoblin_White_Mage'),
        KOENIGSTIGER          = GetFirstID('Koenigstiger'),
        SHADOW_EYE            = GetFirstID('Shadow_Eye'),
        TIMEWORN_WARRIOR      = GetFirstID('Timeworn_Warrior'),
        VOIDWALKER            =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17236241, -- Gorehound
                17236240, -- Gorehound
                17236239, -- Gorehound
                17236238, -- Gorehound
                17236237, -- Gjenganger
                17236236, -- Gjenganger
                17236235, -- Gjenganger
                17236234, -- Gjenganger
            },
            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17236233, -- Erebus
                17236232  -- Feuerunke
            },
            [xi.keyItem.PURPLE_ABYSSITE] =
            {
                17236231  -- Lord Ruthven
            },
            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17236230  -- Yilbegan
            }
        }
    },
    npc =
    {
        BEASTMENS_BANNER = GetFirstID('Beastmens_Banner'),
        BOREAL_COEURL_QM = GetFirstID('qm_boreal_coeurl'),
        BOREAL_HOUND_QM  = GetFirstID('qm_boreal_hound'),
        BOREAL_TIGER_QM  = GetFirstID('qm_boreal_tiger'),
        OPTION_ONE       = GetFirstID('Option_One'),
        OPTION_TWO       = GetFirstID('Option_Two'),
        OPTION_THREE     = GetFirstID('Option_Three'),
        OVERSEER_BASE    = GetFirstID('Jeantelas_RK'),
    },
}

return zones[xi.zone.XARCABARD]
