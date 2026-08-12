-----------------------------------
-- Area: Beaucedine_Glacier
-----------------------------------
zones = zones or {}

zones[xi.zone.BEAUCEDINE_GLACIER] =
{
    text =
    {
        CONQUEST_BASE                  = 0,     -- Tallying conquest results...
        REGION_POINTS_SANDORIA         = 65,    -- San d'Oria's region points have increased!
        EXP_FORCE_KILL_SANDORIA        = 68,    -- San d'Orian E.F. defeats beastmen hordes... Maintain current momentum.
        BEASTMEN_BANNER_CURSE          = 79,    -- There was a curse on the beastmen's banner!
        BEASTMEN_BANNER_LIFTED         = 80,    -- The curse of the beastmen's banner has been lifted!
        BEASTMEN_BANNER                = 81,    -- There is a beastmen's banner.
        ITEM_CANNOT_BE_OBTAINED        = 6570,  -- You cannot obtain the item. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE     = 6572,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                  = 6576,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6577,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6579,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6580,  -- Lost key item: <keyitem>.
        ITEMS_OBTAINED                 = 6585,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY        = 6590,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET          = 6605,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS            = 7187,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 7188,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                   = 7189,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED  = 7209,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET         = 7254,  -- You can't fish here.
        CONQUEST                       = 7508,  -- You've earned conquest points!
        YOU_CANNOT_ENTER_DYNAMIS       = 7888,  -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 7890,  -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 7900,  -- There is an unusual arrangement of branches here.
        GARRISON_BASE                  = 8250,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        PLAYER_OBTAINS_ITEM            = 8583,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM          = 8584,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM       = 8585,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP           = 8586,  -- You already possess that temporary item.
        NO_COMBINATION                 = 8591,  -- You were unable to enter a combination.
        VOIDWALKER_DESPAWN             = 8622,  -- The monster fades before your eyes, a look of disappointment on its face.
        UNITY_WANTED_BATTLE_INTERACT   = 8653,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED              = 10769, -- New training regime registered!
        VOIDWALKER_NO_MOB              = 11888, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR         = 11889, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT            = 11890, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB           = 11891, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1        = 11893, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2        = 11894, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI            = 11895, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI           = 11896, -- Obtained key item: <keyitem>!
        LEARNS_SPELL                   = 12786, -- <name> learns <spell>!
        UNCANNY_SENSATION              = 12788, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL          = 12795, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        GARGANTUA             = GetFirstID('Gargantua'),
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
        HUMBABA               = GetFirstID('Humbaba'),
        KIRATA                = GetFirstID('Kirata'),
        NUE                   = GetFirstID('Nue'),

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17232159, -- Gorehound
                17232158, -- Gorehound
                17232157, -- Gorehound
                17232156, -- Gorehound
                17232155, -- Gjenganger
                17232154, -- Gjenganger
                17232153, -- Gjenganger
                17232152, -- Gjenganger
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17232151, -- Erebus
                17232150, -- Feuerunke
            },

            [xi.keyItem.PURPLE_ABYSSITE] =
            {
                17232149, -- Lord Ruthven
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17232148, -- Yilbegan
            }
        }
    },

    npc =
    {
        BEASTMENS_BANNER = GetFirstID('Beastmens_Banner'),
        MIRROR_POND_J8   = GetFirstID('Mirror_Pond_1'),
        OVERSEER_BASE    = GetFirstID('Parledaire_RK'),
    },
}

return zones[xi.zone.BEAUCEDINE_GLACIER]
