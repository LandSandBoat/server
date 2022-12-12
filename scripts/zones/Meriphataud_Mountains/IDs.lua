-----------------------------------
-- Area: Meriphataud_Mountains
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.MERIPHATAUD_MOUNTAINS] =
{
    text =
    {
        NOTHING_HAPPENS               = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6406,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6412,  -- Obtained: <item>.
        GIL_OBTAINED                  = 6413,  -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6415,  -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6416,  -- Lost key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6441,  -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7023,  -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7024,  -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7025,  -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7045,  -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7082,  -- Tallying conquest results...
        BEASTMEN_BANNER               = 7163,  -- There is a beastmen's banner.
        FISHING_MESSAGE_OFFSET        = 7241,  -- You can't fish here.
        DIG_THROW_AWAY                = 7254,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7256,  -- You dig and you dig, but find nothing.
        AMK_DIGGING_OFFSET            = 7322,  -- You spot some familiar footprints. You are convinced that your moogle friend has been digging in the immediate vicinity.
        NOTHING_FOUND                 = 7499,  -- You find nothing.
        CONQUEST                      = 7911,  -- You've earned conquest points!
        ITEMS_ITEMS_LA_LA             = 8284,  -- You can hear a strange voice... Items, items, la la la la la
        GOBLIN_SLIPPED_AWAY           = 8290,  -- The Goblin slipped away when you were not looking...
        GARRISON_BASE                 = 8300,  -- Hm? What is this? %? How do I know this is not some [San d'Orian/Bastokan/Windurstian] trick?
        PLAYER_OBTAINS_ITEM           = 8347,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM         = 8348,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM      = 8349,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP          = 8350,  -- You already possess that temporary item.
        NO_COMBINATION                = 8355,  -- You were unable to enter a combination.
        VOIDWALKER_DESPAWN            = 8386,  -- The monster fades before your eyes, a look of disappointment on its face.
        UNITY_WANTED_BATTLE_INTERACT  = 8417,  -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        REGIME_REGISTERED             = 10595, -- New training regime registered!
        VOIDWALKER_NO_MOB             = 11714, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR        = 11715, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT           = 11716, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB          = 11717, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1       = 11719, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2       = 11720, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI           = 11721, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI          = 11722, -- Obtained key item: <keyitem>!
        COMMON_SENSE_SURVIVAL         = 12624, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },

    mob =
    {
        NAA_ZEKU_THE_UNWAITING_PH =
        {
            [17264763] = 17264768,
        },

        PATRIPATAN_PH =
        {
            [17264967] = 17264972, -- 551.767, -32.570, 590.205
            [17264968] = 17264972, -- 646.199, -24.483, 644.477
            [17264969] = 17264972, -- 535.318, -32.179, 602.055
        },

        DAGGERCLAW_DRACOS_PH =
        {
            [17264815] = 17264818, -- 583.725 -15.652 -388.159
        },

        WARAXE_BEAK         = 17264828,
        COO_KEJA_THE_UNSEEN = 17264946,

        VOIDWALKER =
        {
            [xi.keyItem.CLEAR_ABYSSITE] =
            {
                17265129, -- Raker bee
                17265128, -- Raker bee
                17265127, -- Raker bee
                17265126, -- Raker bee
                17265125, -- Rummager beetle
                17265124, -- Rummager beetle
                17265123, -- Rummager beetle
                17265122, -- Rummager beetle
            },

            [xi.keyItem.COLORFUL_ABYSSITE] =
            {
                17265121, -- Jyeshtha
                17265120, -- Farruca Fly
            },

            [xi.keyItem.BROWN_ABYSSITE] =
            {
                17265119, -- Orcus
            },

            [xi.keyItem.BLACK_ABYSSITE] =
            {
                17265118, -- Yilbegan
            }
        }
    },

    npc =
    {
        OVERSEER_BASE = 17265271, -- Chegourt_RK in npc_list
    },
}

return zones[xi.zone.MERIPHATAUD_MOUNTAINS]
