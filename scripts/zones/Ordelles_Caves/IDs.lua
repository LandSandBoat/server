-----------------------------------
-- Area: Ordelles Caves (193)
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.ORDELLES_CAVES] =
{
    text =
    {
        CONQUEST_BASE                 = 0,     -- Tallying conquest results...
        ITEM_CANNOT_BE_OBTAINED       = 6542,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6548,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6549,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6551,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6562,  -- There is nothing out of the ordinary here.
        SENSE_OF_FOREBODING           = 6563,  -- You are suddenly overcome with a sense of foreboding...
        FELLOW_MESSAGE_OFFSET         = 6577,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7159,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7160,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                  = 7161,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        GEOMAGNETRON_ATTUNED          = 7170,  -- Your <keyitem> has been attuned to a geomagnetic fount in the corresponding locale.
        FISHING_MESSAGE_OFFSET        = 7212,  -- You can't fish here.
        DEVICE_NOT_WORKING            = 7326,  -- The device is not working.
        SYS_OVERLOAD                  = 7335,  -- Warning! Sys...verload! Enterin...fety mode. ID eras...d.
        YOU_LOST_THE                  = 7340,  -- You lost the <item>.
        RUILLONT_INITIAL_DIALOG       = 7349,  -- Confound it! If I only had my sword, I'd cut through these fiends single-handedly...
        A_SQUIRE_S_TEST_II_DIALOG_I   = 7360,  -- You place your hands into the pool.
        A_SQUIRE_S_TEST_II_DIALOG_II  = 7363,  -- The dew from the stalactite slips through your fingers.
        A_SQUIRE_S_TEST_II_DIALOG_III = 7364,  -- You have already obtained the dew.
        CHEST_UNLOCKED                = 7396,  -- You unlock the chest!
        GERWITZS_AXE_DIALOG           = 7418,  -- Mine axe shall rend thy throat!
        GERWITZS_SWORD_DIALOG         = 7419,  -- Mine sword shall pierce thy tongue!
        GERWITZS_SOUL_DIALOG          = 7420,  -- Long have I waited. I will tell all...
        PLAYER_OBTAINS_ITEM           = 8381,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8382,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8383,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8384,  -- You already possess that temporary item.
        NO_COMBINATION                = 8389,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10467, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 11543, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        DONGGU_PH =
        {
            [17567797] = 17567801,
        },
        AGAR_AGAR_PH =
        {
            [17567897] = 17567901, -- -81.31 31.493 210.675
            [17567898] = 17567901, -- -76.67 31.163 186.602
            [17567899] = 17567901, -- -80.77 31.979 193.542
            [17567900] = 17567901, -- -79.82 31.968 208.309
        },
        MORBOLGER           = 17568127,
        POLEVIK             = 17568134,
        DARK_PUPPET_OFFSET  = 17568135,
        NECROPLASM          = 17568138,
        APPARATUS_ELEMENTAL = 17568139,
        AROMA_LEECH         = 17568140,
    },
    npc =
    {
        CASKET_BASE    = 17568148,
        TREASURE_CHEST = 17568192,
    },
}

return zones[xi.zone.ORDELLES_CAVES]
