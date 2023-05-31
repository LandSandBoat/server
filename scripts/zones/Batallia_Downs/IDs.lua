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
        NOTHING_HAPPENS               = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6406,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6412,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6413,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6415,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6426,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6441,  -- I'm ready. I suppose.
        REPORT_TO_CAIT_SITH           = 7014,  -- You have obtained all of Lilisette's memory fragments. Make haste and report to Cait Sith.
        CARRIED_OVER_POINTS           = 7023,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7024,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7025,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7045,  -- Your party is unable to participate because certain members' levels are restricted.
        UNABLE_TO_PROGRESS            = 7069,  -- ou are unable to make further progress in Rhapsodies of Vana'diel due to an event occurring in the [Chains of Promathia/Treasures of Aht Urhgan/Wings of the Goddess/Seekers of Adoulin/Rise of the Zilart] missions.
        CONQUEST_BASE                 = 7082,  -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7241,  -- You can't fish here.
        DIG_THROW_AWAY                = 7254,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7256,  -- You dig and you dig, but find nothing.
        SPARKLING_LIGHT               = 7350,  -- The ground is sparkling with a strange light.
        SENSE_SOMETHING_LURKING       = 7440,  -- You sense something lurking close by!
        NO_GRASS_GROWING_HERE         = 7488,  -- There is no grass growing here...
        YOU_ARE_BEING_ATTACKED        = 7625,  -- You are being attacked!
        YOU_FIND_NOTHING              = 7628,  -- You find nothing.
        PLAYER_OBTAINS_ITEM           = 7700,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 7701,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 7702,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 7703,  -- You already possess that temporary item.
        NO_COMBINATION                = 7708,  -- You were unable to enter a combination.
        VOIDWALKER_DESPAWN            = 7739,  -- The monster fades before your eyes, a look of disappointment on its face.
        UNITY_WANTED_BATTLE_INTERACT  = 7770,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 9986,  -- New training regime registered!
        FRAGMENT_FAR_TOO_SMALL        = 11324, -- You obtain <keyitem>. However, it is far too small to house an adequate amount of energy. Alone, it serves no purpose.
        FRAGMENTS_MELD                = 11325, -- The tiny fragments of Lilisette's memory meld together to form <keyitem>!
        SEE_WEATHERED_GRAVESTONE      = 11326, -- You see a weathered gravestone.
        VOIDWALKER_NO_MOB             = 11327, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 11328, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 11329, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 11330, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 11332, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 11333, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 11334, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 11335, -- Obtained key item: <keyitem>!
        LEARNS_SPELL                  = 12835, -- <name> learns <spell>!
        UNCANNY_SENSATION             = 12837, -- You are assaulted by an uncanny sensation.
        COMMON_SENSE_SURVIVAL         = 12844, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        RAPTOR_OVERCOME_MUNCHIES      = 12997, -- The raptor has overcome the munchies! (<number>/<number>)
        RAPTOR_SECOND_WIND            = 12998, -- The raptor has gained a second wind!
        MEET_SYRILLIA                 = 12999, -- Meet up with Syrillia.
        RAPTOR_SPEEDS_OFF             = 13000, -- The raptor speeds off into the sunset...
    },
    mob =
    {
        PRANKSTER_MAVERIX_PH =
        {
            [17207635] = 17207640,
        },

        TOTTERING_TOBY_PH =
        {
            [17207449] = 17207476, -- -194.234 -18.485 132.208
        },

        AHTU              = 17207657,
        BADSHAH_OFFSET    = GetFirstID('Badshah'),
        STURMTIGER        = 17207696,
        SUPARNA           = 17207697,
        SUPARNA_FLEDGLING = 17207698,
        VEGNIX_GREENTHUMB = 17207710,

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17207722,  -- Lacus
                17207721,  -- Thunor
                17207720, -- Beorht
                17207719, -- Pruina
                17207718,  -- Puretos
                17207717,  -- Eorthe
                17207716, -- Deorc
                17207715, -- Aither
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17207714, -- Skuld
                17207713  -- Urd
            },

            [xi.keyItem.YELLOW_ABYSSITE] =
            {
                17207712  -- Verthandi
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17207711  -- Yilbegan
            }
        }
    },

    npc =
    {
        SYRILLIA         = GetFirstID("Syrillia"),
        BLUE_BEAM_BASE   = GetFirstID("NPC[2a4]"),
        RAPTOR_FOOD_BASE = GetFirstID("Raptors_Food_0"),
    },
}

return zones[xi.zone.BATALLIA_DOWNS]
