-----------------------------------
-- Area: West_Sarutabaruta
-----------------------------------
zones = zones or {}

zones[xi.zone.WEST_SARUTABARUTA] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6385,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6392,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6395,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6405,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6420,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7002,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7003,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7004,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7024,  -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7068,  -- You can't fish here.
        DIG_THROW_AWAY                = 7081,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7083,  -- You dig and you dig, but find nothing.
        FOUND_ITEM_WITH_EASE          = 7158,  -- It appears your chocobo found this item with ease.
        CONQUEST_BASE                 = 7168,  -- Tallying conquest results...
        SIGN_1                        = 7397,  -- Northeast: Central Tower, Horutoto Ruins Northwest: Giddeus South: Port Windurst
        SIGN_3                        = 7398,  -- East: East Sarutabaruta West: Giddeus
        SIGN_5                        = 7399,  -- Northeast: Central Tower, Horutoto Ruins East: East Sarutabaruta West: Giddeus
        SIGN_7                        = 7400,  -- South: Windurst East: East Sarutabaruta
        SIGN_9                        = 7401,  -- West: Giddeus North: East Sarutabaruta South: Windurst
        SIGN_11                       = 7402,  -- North: East Sarutabaruta Southeast: Windurst
        SIGN_13                       = 7403,  -- East: Port Windurst West: West Tower, Horutoto Ruins
        SIGN_15                       = 7404,  -- East: East Sarutabaruta West: Giddeus Southeast: Windurst
        SIGN_17                       = 7405,  -- Northwest: Northwest Tower, Horutoto Ruins  East: Outpost Southwest: Giddeus
        PAORE_KUORE_DIALOG            = 7407,  -- Welcome to Windurst! Proceed through this gateway to entaru Port Windurst.
        KOLAPO_OILAPO_DIALOG          = 7408,  -- Hi-diddly-diddly! This is the gateway to Windurst! The grasslands you're on now are known as West Sarutabaruta.
        MAATA_ULAATA                  = 7409,  -- Hello-wello! This is the central tower of the Horutoto Ruins. It's one of the several ancient-wancient magic towers which dot these grasslands.
        COME_FROM_THE_ORASTERY        = 7410,  -- I am Fuahah. I've come from the Orastery's Mage Academy to investigate the Horutoto Ruins.
        FERAL_CARDIANS                = 7411,  -- Beneath this magic tower lurk some of the feral Cardians that have escaped from the care of the Manustery. So be very-wery careful down there!
        IPUPU_DIALOG                  = 7412,  -- I decided to take a little strolly-wolly, but before I realized it, I found myself way out here! Now I am sorta stuck... Woe is me!
        FROST_DEPOSIT_TWINKLES        = 7419,  -- A frost deposit at the base of the tree twinkles in the starlight.
        MELT_BARE_HANDS               = 7421,  -- It looks like it would melt if you touched it with your bare hands...
        HARVESTING_IS_POSSIBLE_HERE   = 7457,  -- Harvesting is possible here if you have <item>.
        CONQUEST                      = 7473,  -- You've earned conquest points!
        GARRISON_BASE                 = 7827,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        PLAYER_OBTAINS_ITEM           = 7874,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7875,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7876,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7877,  -- You already possess that temporary item.
        NO_COMBINATION                = 7882,  -- You were unable to enter a combination.
        VOIDWALKER_DESPAWN            = 7913,  -- The monster fades before your eyes, a look of disappointment on its face.
        REGIME_REGISTERED             = 10204, -- New training regime registered!
        DONT_SWAP_JOBS                = 10205, -- hanging your job will result in the cancellation of your current training regime.
        REGIME_CANCELED               = 10206, -- Training regime canceled.
        VOIDWALKER_NO_MOB             = 11364, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 11365, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 11366, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 11367, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 11369, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 11370, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 11371, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 11372, -- Obtained key item: <keyitem>!
        COMMON_SENSE_SURVIVAL         = 12355, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },

    mob =
    {
        NUNYENUNC   = GetFirstID('Nunyenunc'),
        TOM_TIT_TAT = GetFirstID('Tom_Tit_Tat'),
        VOIDWALKER  =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17248624, -- Raker bee
                17248623, -- Raker bee
                17248622, -- Raker bee
                17248621, -- Raker bee
                17248620,  -- Rummager beetle
                17248619,  -- Rummager beetle
                17248618,  -- Rummager beetle
                17248617,  -- Rummager beetle
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17248616,  -- Jyeshtha
                17248615, -- Farruca Fly
            },

            [xi.keyItem.BROWN_ABYSSITE] =
            {
                17248614, -- Orcus
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17248613, -- Yilbegan
            },
        }
    },

    npc =
    {
        SIGNPOST_OFFSET = GetFirstID('Signpost'),
        OVERSEER_BASE   = GetFirstID('Naguipeillont_RK'),
        HARVESTING      = GetTableOfIDs('Harvesting_Point'),
    },
}

return zones[xi.zone.WEST_SARUTABARUTA]
