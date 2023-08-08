-----------------------------------
-- Area: Beaucedine_Glacier
-----------------------------------
zones = zones or {}

zones[xi.zone.BEAUCEDINE_GLACIER] =
{
    text =
    {
        CONQUEST_BASE                  = 0,     -- Tallying conquest results...
        BEASTMEN_BANNER                = 81,    -- There is a beastmen's banner.
        ITEM_CANNOT_BE_OBTAINED        = 6567,  -- You cannot obtain the item. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE     = 6569,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                  = 6571,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6572,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6574,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6575,  -- Lost key item: <keyitem>.
        ITEMS_OBTAINED                 = 6580,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY        = 6585,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET          = 6600,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS            = 7182,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 7183,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                   = 7184,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED  = 7204,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET         = 7241,  -- You can't fish here.
        CONQUEST                       = 7494,  -- You've earned conquest points!
        YOU_CANNOT_ENTER_DYNAMIS       = 7873,  -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 7875,  -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 7885,  -- There is an unusual arrangement of branches here.
        GARRISON_BASE                  = 8235,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        PLAYER_OBTAINS_ITEM            = 8568,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM          = 8569,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM       = 8570,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP           = 8571,  -- You already possess that temporary item.
        NO_COMBINATION                 = 8576,  -- You were unable to enter a combination.
        VOIDWALKER_DESPAWN             = 8607,  -- The monster fades before your eyes, a look of disappointment on its face.
        UNITY_WANTED_BATTLE_INTERACT   = 8638,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED              = 10754, -- New training regime registered!
        VOIDWALKER_NO_MOB              = 11873, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR         = 11874, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT            = 11875, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB           = 11876, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1        = 11878, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2        = 11879, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI            = 11880, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI           = 11881, -- Obtained key item: <keyitem>!
        LEARNS_SPELL                   = 12771, -- <name> learns <spell>!
        UNCANNY_SENSATION              = 12773, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL          = 12780, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        GARGANTUA_PH =
        {
            [GetFirstID("Gargantua") - 1] = GetFirstID("Gargantua"), -- 339 -0.472 -20
        },

        KIRATA_PH =
        {
            [GetFirstID("Kirata") - 2] = GetFirstID("Kirata"), -- 75.797 -0.335 -323.659
            [GetFirstID("Kirata") - 1] = GetFirstID("Kirata"), -- 69.336 -0.234 -276.561
        },

        NUE_PH =
        {
            [GetFirstID("Nue") - 2] = GetFirstID("Nue"), -- -342.830 -100.584 168.662
            [GetFirstID("Nue") - 1] = GetFirstID("Nue"), -- -322.000 -100.000 116.000
        },

        HUMBABA = GetFirstID("Humbaba"),

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                GetFirstID("Gorehound") + 3,  -- Gorehound
                GetFirstID("Gorehound") + 2,  -- Gorehound
                GetFirstID("Gorehound") + 1,  -- Gorehound
                GetFirstID("Gorehound"),      -- Gorehound
                GetFirstID("Gjenganger") + 3, -- Gjenganger
                GetFirstID("Gjenganger") + 2, -- Gjenganger
                GetFirstID("Gjenganger") + 1, -- Gjenganger
                GetFirstID("Gjenganger"),     -- Gjenganger
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                GetFirstID("Erebus"),
                GetFirstID("Feuerunke"),
            },

            [xi.keyItem.PURPLE_ABYSSITE] =
            {
                GetFirstID("Lord_Ruthven"),
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                GetFirstID("Yilbegan"),
            },
        }
    },

    npc =
    {
        MIRROR_POND_J8 = GetFirstID("Mirror_Pond_1"), -- Mirror_Pond_1 in npc_list
        OVERSEER_BASE  = GetFirstID("Parledaire_RK"),
    },
}

return zones[xi.zone.BEAUCEDINE_GLACIER]
