-----------------------------------
-- Area: Rolanberry_Fields_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.ROLANBERRY_FIELDS_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6389, -- Obtained: <item>.
        GIL_OBTAINED            = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6392, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS     = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        FISHING_MESSAGE_OFFSET  = 7070, -- You can't fish here.
        COMMON_SENSE_SURVIVAL   = 9250, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        --Voidwalker
        VOIDWALKER_NO_MOB        = 8037, -- The <abyssite> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR   = 8038, -- The <abyssite> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT      = 8039, -- The <abyssite> resonates <hint>, sending a radiant beam of light lancing towards a spot roughly <distance> <direction> of here.
        VOIDWALKER_SPAWN_MOB     = 8040, -- A monster materializes out of nowhere!
        VOIDWALKER_DESPAWN       = 8041, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_UPGRADE_KI_1  = 8042, -- The <current abyssite> takes on a slightly deeper hue and becomes <next abyssite>!
        VOIDWALKER_UPGRADE_KI_2  = 8043, -- The <current abyssite> takes on a deeper, richer hue and becomes <next abyssite>!
        VOIDWALKER_BREAK_KI      = 8044, -- The <abyssite> shatters into tiny fragments.
        VOIDWALKER_OPTAIN_KI     = 8045, -- Obtained key item: ≺abyssite>!   
    },
    mob =
    {
        DELICIEUSE_DELPHINE_PH =
        {
            [17150279] = 17150280, -- -484.535 -23.756 -467.462
        },
        VOIDWALKER        =
        {
            [xi.keyItem.CLEAR_ABYSSITE] = {
                17150346,  -- Lacus
                17150345,  -- Thunor
                17150344, -- Beorht
                17150343, -- Pruina
                17150342,  -- Puretos
                17150341,  -- Eorthe
                17150340, -- Deorc
                17150339, -- Aither
            },
            [xi.keyItem.COLORFUL_ABYSSITE] = {
                17150338, -- Skuld
                17150337  -- Urd
            },
            [xi.keyItem.YELLOW_ABYSSITE] = {
                17150336  -- Verthandi
            },
            [xi.keyItem.BLACK_ABYSSITE] = {
                17150335  -- Yilbegan
            }
        }
    },
    npc =
    {
    },
}

return zones[xi.zone.ROLANBERRY_FIELDS_S]
