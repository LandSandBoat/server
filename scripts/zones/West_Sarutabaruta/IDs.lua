-----------------------------------
-- Area: West_Sarutabaruta
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.WEST_SARUTABARUTA] =
{
    text =
    {
        NOTHING_HAPPENS             = 119,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED     = 6383,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED               = 6389,  -- Obtained: <item>.
        GIL_OBTAINED                = 6390,  -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6392,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                = 6393,  -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY     = 6403,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET       = 6418,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS         = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY     = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        FISHING_MESSAGE_OFFSET      = 7050,  -- You can't fish here.
        DIG_THROW_AWAY              = 7063,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                = 7065,  -- You dig and you dig, but find nothing.
        CONQUEST_BASE               = 7150,  -- Tallying conquest results...
        SIGN_1                      = 7379,  -- Northeast: Central Tower, Horutoto Ruins Northwest: Giddeus South: Port Windurst
        SIGN_3                      = 7380,  -- East: East Sarutabaruta West: Giddeus
        SIGN_5                      = 7381,  -- Northeast: Central Tower, Horutoto Ruins East: East Sarutabaruta West: Giddeus
        SIGN_7                      = 7382,  -- South: Windurst East: East Sarutabaruta
        SIGN_9                      = 7383,  -- West: Giddeus North: East Sarutabaruta South: Windurst
        SIGN_11                     = 7384,  -- North: East Sarutabaruta Southeast: Windurst
        SIGN_13                     = 7385,  -- East: Port Windurst West: West Tower, Horutoto Ruins
        SIGN_15                     = 7386,  -- East: East Sarutabaruta West: Giddeus Southeast: Windurst
        SIGN_17                     = 7387,  -- Northwest: Northwest Tower, Horutoto Ruins  East: Outpost Southwest: Giddeus
        PAORE_KUORE_DIALOG          = 7389,  -- Welcome to Windurst! Proceed through this gateway to entaru Port Windurst.
        KOLAPO_OILAPO_DIALOG        = 7390,  -- Hi-diddly-diddly! This is the gateway to Windurst! The grasslands you're on now are known as West Sarutabaruta.
        MAATA_ULAATA                = 7391,  -- Hello-wello! This is the central tower of the Horutoto Ruins. It's one of the several ancient-wancient magic towers which dot these grasslands.
        IPUPU_DIALOG                = 7394,  -- I decided to take a little strolly-wolly, but before I realized it, I found myself way out here! Now I am sorta stuck... Woe is me!
        FROST_DEPOSIT_TWINKLES      = 7401,  -- A frost deposit at the base of the tree twinkles in the starlight.
        MELT_BARE_HANDS             = 7403,  -- It looks like it would melt if you touched it with your bare hands...
        HARVESTING_IS_POSSIBLE_HERE = 7439,  -- Harvesting is possible here if you have <item>.
        CONQUEST                    = 7455,  -- You've earned conquest points!
        PLAYER_OBTAINS_ITEM         = 7874,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM       = 7875,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM    = 7876,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP        = 7877,  -- You already possess that temporary item.
        NO_COMBINATION              = 7882,  -- You were unable to enter a combination.
        REGIME_REGISTERED           = 10202, -- New training regime registered!
        DONT_SWAP_JOBS              = 10203, -- hanging your job will result in the cancellation of your current training regime.
        REGIME_CANCELED             = 10204, -- Training regime canceled.
        COMMON_SENSE_SURVIVAL       = 12353, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        VOIDWALKER_NO_MOB           = 11362, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR      = 11363, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT         = 11364, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB        = 11365, -- A monster materializes out of nowhere!
        VOIDWALKER_DESPAWN          = 11366, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_UPGRADE_KI_1     = 11367, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2     = 11368, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI         = 11369, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI        = 11370, -- Obtained key item: <keyitem>!
    },
    mob =
    {
        NUNYENUNC_PH   =
        {
            [17248323] = 17248517, -- -95.00 -17.000 383.000
            [17248515] = 17248517, -- -7.194 -17.288 431.604
            [17248516] = 17248517, -- 53.159 -24.540 554.652
            [17248514] = 17248517, -- 159.501 -20.117 485.528
        },
        TOM_TIT_TAT_PH =
        {
            [17248467] = 17248468, -- 31.149 -20.045 358.265
            [17248466] = 17248468, -- 77.509 -20.719 434.757
            [17248507] = 17248468, -- 139.154 -21.418 505.416
            [17248506] = 17248468, -- 151.484 -21.133 494.038
            [17248543] = 17248468, -- 211.910 -19.944 546.316
            [17248546] = 17248468, -- 211.099 -20.673 568.574
            [17248544] = 17248468, -- 239.421 -19.659 583.122
            [17248545] = 17248468, -- 274.296 -20.357 587.339
        },
        VOIDWALKER        =
        {
            [xi.keyItem.CLEAR_ABYSSITE] = {
                17248624, -- Raker bee
                17248623, -- Raker bee
                17248622, -- Raker bee
                17248621, -- Raker bee
                17248620,  -- Rummager beetle
                17248619,  -- Rummager beetle
                17248618,  -- Rummager beetle
                17248617,  -- Rummager beetle
            },
            [xi.keyItem.COLORFUL_ABYSSITE] = {
                17248616,  -- Jyeshtha
                17248615, -- Farruca Fly
            },
            [xi.keyItem.BROWN_ABYSSITE] = {
                17248614  -- Orcus
            },
            [xi.keyItem.BLACK_ABYSSITE] = {
                17248613  -- Yilbegan
            }
        }
    },
    npc =
    {
        CASKET_BASE     = 17248769,
        SIGNPOST_OFFSET = 17248796,
        OVERSEER_BASE   = 17248829, -- Naguipeillont_RK in npc_list
        HARVESTING =
        {
            17248845,
            17248846,
            17248847,
            17248848,
            17248849,
            17248850,
        },
    },
}

return zones[xi.zone.WEST_SARUTABARUTA]
