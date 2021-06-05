-----------------------------------
-- Area: North_Gustaberg
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.NORTH_GUSTABERG] =
{
    text =
    {
        CONQUEST_BASE                 = 0,     -- Tallying conquest results...
        NOTHING_HAPPENS               = 300,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED_TWICE = 6563,  -- You cannot obtain any more.
        ITEM_CANNOT_BE_OBTAINED       = 6564,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        FULL_INVENTORY_AFTER_TRADE    = 6568,  -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED                 = 6570,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6571,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6573,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6574,  -- Lost key item: <keyitem>.
        ITEMS_OBTAINED                = 6579,  -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6584,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6599,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7181, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7182, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                  = 7183, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        FISHING_MESSAGE_OFFSET        = 7231,  -- You can't fish here.
        DIG_THROW_AWAY                = 7244,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7246,  -- You dig and you dig, but find nothing.
        SPARKLING_LIGHT               = 7375,  -- The ground is sparkling with a strange light.
        SHINING_OBJECT_SLIPS_AWAY     = 7439,  -- The shining object slips through your fingers and is washed further down the stream.
        REACH_WATER_FROM_HERE         = 7446,  -- You can reach the water from here.
        CONQUEST                      = 7482,  -- You've earned conquest points!
        ITEMS_ITEMS_LA_LA             = 7852,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY           = 7858,  -- The Goblin slipped away when you were not looking...
        PLAYER_OBTAINS_ITEM           = 8083,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8084,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8085,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8086,  -- You already possess that temporary item.
        NO_COMBINATION                = 8091,  -- You were unable to enter a combination.
        REGIME_REGISTERED             = 10412, -- New training regime registered!
        COMMON_SENSE_SURVIVAL         = 12485, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        VOIDWALKER_NO_MOB             = 11531, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 11532, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 11533, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 11534, -- A monster materializes out of nowhere!
        VOIDWALKER_DESPAWN            = 11535, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_UPGRADE_KI_1       = 11536, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 11537, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 11538, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 11539, -- Obtained key item: <keyitem>!
    },
    mob =
    {
        STINGING_SOPHIE_PH  =
        {
            [17211532] = 17211561, -- 352.974 -40.359 472.914
            [17211534] = 17211561, -- 353.313 -40.347 463.609
            [17211535] = 17211561, -- 237.753 -40.500 469.738
            [17211533] = 17211561, -- 216.150 -41.182 445.157
            [17211536] = 17211561, -- 197.369 -40.612 453.688
            [17211531] = 17211561, -- 196.873 -40.415 500.153
            [17211556] = 17211561, -- 210.607 -40.478 566.096
            [17211557] = 17211561, -- 288.447 -40.842 634.161
            [17211558] = 17211561, -- 295.890 -41.593 614.738
            [17211560] = 17211561, -- 356.544 -40.528 570.302
            [17211559] = 17211561, -- 363.973 -40.774 562.355
            [17211581] = 17211561, -- 308.116 -60.352 550.771
            [17211582] = 17211561, -- 308.975 -61.082 525.690
            [17211580] = 17211561, -- 310.309 -60.634 521.404
            [17211583] = 17211561, -- 285.813 -60.784 518.539
            [17211579] = 17211561, -- 283.958 -60.926 530.016
        },
        MAIGHDEAN_UAINE_PH  =
        {
            [17211698] = 17211702, -- 121.242 -0.500 654.504
            [17211701] = 17211702, -- 176.458 -0.347 722.666
            [17211697] = 17211702, -- 164.140 1.981 740.020
            [17211710] = 17211702, -- 239.992 -0.493 788.037
            [17211700] = 17211702, -- 203.606 -0.607 721.541
            [17211711] = 17211702, -- 289.709 -0.297 750.252
        },
        GAMBILOX_WANDERLING = 17211848,
        VOIDWALKER  =
        {
            [xi.keyItem.CLEAR_ABYSSITE] = {
                17211881, -- Globster
                17211880, -- Globster
                17211879, -- Globster
                17211878, -- Globster
                17211877,  -- Ground Guzzler
                17211876,  -- Ground Guzzler
                17211875,  -- Ground Guzzler
                17211874,  -- Ground Guzzler
            },
            [xi.keyItem.COLORFUL_ABYSSITE] = {
                17211873, -- Lamprey Lord
                17211872,  -- Shoggoth
            },
            [xi.keyItem.ORANGE_ABYSSITE] = {
                17211865  -- Blobdingnag
            },
            [xi.keyItem.BLACK_ABYSSITE] = {
                17211864  -- Yilbegan
            }
        }
    },
    pet =
    {
        [17211865] = -- Blobdingnag
        {
            17211871,-- Septic Boils
            17211870,-- Septic Boils
            17211869,-- Septic Boils
            17211868,-- Septic Boils
            17211867,-- Septic Boils
            17211866,-- Septic Boils
        },
    },
    npc =
    {
        CASKET_BASE   = 17212022,
        OVERSEER_BASE = 17212059, -- Ennigreaud_RK in npc_list
    },
}

return zones[xi.zone.NORTH_GUSTABERG]
