-----------------------------------
-- Area: Xarcabard
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.XARCABARD] =
{
    text =
    {
        NOTHING_HAPPENS                = 119,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED        = 6396,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                  = 6402,  -- Obtained: <item>.
        GIL_OBTAINED                   = 6403,  -- Obtained <number> gil.
        KEYITEM_OBTAINED               = 6405,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                   = 6406,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY        = 6416,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET          = 6431,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS            = 7013, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY        = 7014, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                   = 7015, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE                  = 7063,  -- Tallying conquest results...
        BEASTMEN_BANNER                = 7142,  -- There was a curse on the beastmen's banner!
        ALREADY_OBTAINED_TELE          = 7372,  -- You already possess the gate crystal for this telepoint.
        CONQUEST                       = 7385,  -- You've earned conquest points!
        ONLY_SHARDS                    = 7718,  -- Only shards of ice lie upon the ground.
        BLOCKS_OF_ICE                  = 7719,  -- You can hear blocks of ice moving from deep within the cave.
        PERENNIAL_SNOW_DEFAULT         = 7720,  -- How many millennia has this snow been here, hidden from the rays of the sun?
        PERENNIAL_SNOW_WAIT            = 7722,  -- The <keyitem> you buried is not yet purified.
        YOU_CANNOT_ENTER_DYNAMIS       = 7862,  -- You cannot enter Dynamis - [Dummy/San d'Oria/Bastok/Windurst/Jeuno/Beaucedine/Xarcabard/Valkurm/Buburimu/Qufim/Tavnazia] for <number> [day/days] (Vana'diel time).
        PLAYERS_HAVE_NOT_REACHED_LEVEL = 7864,  -- Players who have not reached level <number> are prohibited from entering Dynamis.
        DYNA_NPC_DEFAULT_MESSAGE       = 7875,  -- There is an unusual arrangement of pebbles here.
        PLAYER_OBTAINS_ITEM            = 8179,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM          = 8180,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM       = 8181,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP           = 8182,  -- You already possess that temporary item.
        NO_COMBINATION                 = 8187,  -- You were unable to enter a combination.
        REGIME_REGISTERED              = 10365, -- New training regime registered!
        COMMON_SENSE_SURVIVAL          = 11550, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        VOIDWALKER_NO_MOB              = 11484, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR         = 11485, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT            = 11486, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB           = 11487, -- A monster materializes out of nowhere!
        VOIDWALKER_DESPAWN             = 11488, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_UPGRADE_KI_1        = 11489, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2        = 11490, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI            = 11491, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI           = 11492, -- Obtained key item: <keyitem>!
    },
    mob =
    {
        BARBARIC_WEAPON_PH =
        {
            [17236026] = 17236027,
        },
        TIMEWORN_WARRIOR_PH =
        {
            [17236041] = 17236045,
            [17236042] = 17236045,
            [17236043] = 17236045,
            [17236044] = 17236045,
            [17236046] = 17236045,
            [17236047] = 17236045,
            [17236048] = 17236045,
            [17236049] = 17236045,
        },
        SHADOW_EYE_PH =
        {
            [17236149] = 17236180, -- -223.872 -11.784 80.972
            [17236174] = 17236180, -- -254.799 -15.003 -8.120
            [17236175] = 17236180, -- -240.218 -12.523 42.568
            [17236176] = 17236180, -- -245.251 -11.741 106.221
            [17236177] = 17236180, -- -217.075 -8.306 51.115
            [17236178] = 17236180, -- -234.354 -11.492 63.501
        },
        CHAOS_ELEMENTAL = 17236201,
        BOREAL_HOUND    = 17236202,
        BOREAL_COEURL   = 17236203,
        BOREAL_TIGER    = 17236204,
        KOENIGSTIGER    = 17236205,
        VOIDWALKER      =
        {
            [xi.keyItem.CLEAR_ABYSSITE] = {
                17236241, -- Gorehound
                17236240, -- Gorehound
                17236239, -- Gorehound
                17236238, -- Gorehound
                17236237, -- Gjenganger
                17236236, -- Gjenganger
                17236235, -- Gjenganger
                17236234, -- Gjenganger
            },
            [xi.keyItem.COLORFUL_ABYSSITE] = {
                17236233, -- Erebus
                17236232  -- Feuerunke
            },
            [xi.keyItem.PURPLE_ABYSSITE] = {
                17236231  -- Lord Ruthven
            },
            [xi.keyItem.BLACK_ABYSSITE] = {
                17236230  -- Yilbegan
            }
        }
    },
    npc =
    {
        CASKET_BASE        = 17236254,
        OVERSEER_BASE      = 17236289, -- Jeantelas_RK in npc_list
        BOREAL_TIGER_QM    = 17236307, -- qm2 in npc_list
        BOREAL_COEURL_QM   = 17236308, -- qm3 in npc_list
        BOREAL_HOUND_QM    = 17236309, -- qm4 in npc_list
    },
}

return zones[xi.zone.XARCABARD]
