-----------------------------------
-- Area: Rolanberry_Fields
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.ROLANBERRY_FIELDS] =
{
    text =
    {
        NOTHING_HAPPENS          = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED  = 6405,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6411,  -- Obtained: <item>.
        GIL_OBTAINED             = 6412,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6414,  -- Obtained key item: <keyitem>.
        NOT_ENOUGH_GIL           = 6416,  -- You do not have enough gil.
        FELLOW_MESSAGE_OFFSET    = 6440,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7022,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7023,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7024,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE            = 7075,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET   = 7234,  -- You can't fish here.
        DIG_THROW_AWAY           = 7247,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING             = 7249,  -- You dig and you dig, but find nothing.
        SIGN                     = 7404,  -- North: Grand Duchy of Jeuno, Sauromugue Champaign South: Pashhow Marshlands
        PLAYER_OBTAINS_ITEM      = 7603,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 7604,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 7605,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 7606,  -- You already possess that temporary item.
        NO_COMBINATION           = 7611,  -- You were unable to enter a combination.
        VOIDWALKER_DESPAWN       = 7642,  -- The monster fades before your eyes, a look of disappointment on its face.
        REGIME_REGISTERED        = 9789,  -- New training regime registered!
        VOIDWALKER_NO_MOB        = 10962, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR   = 10963, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT      = 10964, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB     = 10965, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1  = 10967, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2  = 10968, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI      = 10969, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI     = 10970, -- Obtained key item: <keyitem>!
        AWAIT_YOUR_CHALLENGE     = 12187, -- We await your challenge, traveler.
        LACK_LEGION_POINTS       = 12224, -- It would seem that you lack the necessary amount of Legion points.
        COMMON_SENSE_SURVIVAL    = 12281, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BLACK_TRIPLE_STARS_PH =
        {
            [17227968] = 17227972, -- 4 -16 -119 (north)
            [17227988] = 17227992, -- 76 -15 -209 (south)
        },
        DROOLING_DAISY_PH =
        {
            [17228235] = 17228236, -- -691.786 -34.802 -335.763
        },
        ELDRITCH_EDGE_PH  =
        {
            [17228152] = 17228150, -- 440 -28 -44
            [17228148] = 17228150, -- 396.992 -24.01 -152.613
            [17228149] = 17228150, -- 395 -24 -147
        },
        SILK_CATERPILLAR  = 17227782,
        SIMURGH           = 17228242,
        CHUGLIX_BERRYPAWS = 17228249,
        VOIDWALKER        =
        {
            [xi.keyItem.CLEAR_ABYSSITE] = {
                17228261,  -- Lacus
                17228260,  -- Thunor
                17228259, -- Beorht
                17228258, -- Pruina
                17228257,  -- Puretos
                17228256,  -- Eorthe
                17228255, -- Deorc
                17228254, -- Aither
            },
            [xi.keyItem.COLORFUL_ABYSSITE] = {
                17228253, -- Skuld
                17228252  -- Urd
            },
            [xi.keyItem.YELLOW_ABYSSITE] = {
                17228251  -- Verthandi
            },
            [xi.keyItem.BLACK_ABYSSITE] = {
                17228250  -- Yilbegan
            }
        }
    },
    npc =
    {
        CASKET_BASE = 17228318,
    },
}

return zones[xi.zone.ROLANBERRY_FIELDS]
