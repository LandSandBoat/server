-----------------------------------
-- Area: Batallia_Downs
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.BATALLIA_DOWNS] =
{
    text =
    {
        NOTHING_HAPPENS          = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED  = 6405,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6411,  -- Obtained: <item>.
        GIL_OBTAINED             = 6412,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6414,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6425,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET    = 6440,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS      = 7022, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7023, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7024, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE            = 7072,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET   = 7231,  -- You can't fish here.
        DIG_THROW_AWAY           = 7244,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING             = 7246,  -- You dig and you dig, but find nothing.
        SPARKLING_LIGHT          = 7340,  -- The ground is sparkling with a strange light.
        PLAYER_OBTAINS_ITEM      = 7709,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 7710,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 7711,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 7712,  -- You already possess that temporary item.
        NO_COMBINATION           = 7717,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 9995,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 12851, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        RAPTOR_OVERCOME_MUNCHIES = 13004, -- The raptor has overcome the munchies! (<number>/<number>)
        RAPTOR_SECOND_WIND       = 13005, -- The raptor has gained a second wind!
        MEET_SYRILLIA            = 13006, -- Meet up with Syrillia.
        RAPTOR_SPEEDS_OFF        = 13007, -- The raptor speeds off into the sunset...
        VOIDWALKER_NO_MOB        = 11336, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR   = 11337, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT      = 11338, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB     = 11339, -- A monster materializes out of nowhere!
        VOIDWALKER_DESPAWN       = 11340, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_UPGRADE_KI_1  = 11341, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2  = 11342, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI      = 11343, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI     = 11344, -- Obtained key item: <keyitem>!

    },
    mob =
    {
        PRANKSTER_MAVERIX_PH =
        {
            [17207635] = 17207640,
            [17207636] = 17207640,
            [17207637] = 17207640,
            [17207638] = 17207640,
            [17207639] = 17207640,
        },
        TOTTERING_TOBY_PH =
        {
            [17207449] = 17207476, -- -194.234 -18.485 132.208
        },
        AHTU              = 17207657,
        STURMTIGER        = 17207696,
        SUPARNA           = 17207697,
        SUPARNA_FLEDGLING = 17207698,
        VEGNIX_GREENTHUMB = 17207710,
        VOIDWALKER        =
        {
            [xi.keyItem.CLEAR_ABYSSITE] = {
                17207722,  -- Lacus
                17207721,  -- Thunor
                17207720, -- Beorht
                17207719, -- Pruina
                17207718,  -- Puretos
                17207717,  -- Eorthe
                17207716, -- Deorc
                17207715, -- Aither
            },
            [xi.keyItem.COLORFUL_ABYSSITE] = {
                17207714, -- Skuld
                17207713  -- Urd
            },
            [xi.keyItem.YELLOW_ABYSSITE] = {
                17207712  -- Verthandi
            },
            [xi.keyItem.BLACK_ABYSSITE] = {
                17207711  -- Yilbegan
            }
        }
    },
    npc =
    {
        CASKET_BASE      = 17207793,
        SYRILLIA         = 17207971,
        BLUE_BEAM_BASE   = 17207972, -- NPC[2a4] in npc_list
        RAPTOR_FOOD_BASE = 17207980,
    },
}

return zones[xi.zone.BATALLIA_DOWNS]
