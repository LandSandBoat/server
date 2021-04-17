-----------------------------------
-- Area: Batallia_Downs_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.BATALLIA_DOWNS_S] =
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
        LYCOPODIUM_ENTRANCED    = 7057, -- The lycopodium is entranced by a sparkling light...
        FISHING_MESSAGE_OFFSET  = 7070, -- You can't fish here.
        COMMON_SENSE_SURVIVAL   = 9584, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        -- Voidwalker
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
        BURLIBIX_BRAWNBACK_PH =
        {
            [17121398] = 17121399,
            [17121402] = 17121399,
        },
        LA_VELUE_PH =
        {
            [17121554] = 17121576, -- -314.365 -18.745 -56.016
        },
        HABERGOASS_PH =
        {
            [17121602] = 17121603,
        },
        VOIDWALKER        =
        {
            [xi.keyItem.CLEAR_ABYSSITE] = {
                17121722,  -- Lacus
                17121721,  -- Thunor
                17121720, -- Beorht
                17121719, -- Pruina
                17121718,  -- Puretos
                17121717,  -- Eorthe
                17121716, -- Deorc
                17121715, -- Aither
            },
            [xi.keyItem.COLORFUL_ABYSSITE] = {
                17121714, -- Skuld
                17121713  -- Urd
            },
            [xi.keyItem.YELLOW_ABYSSITE] = {
                17121712  -- Verthandi
            },
            [xi.keyItem.BLACK_ABYSSITE] = {
                17121711  -- Yilbegan
            }
        }
    },
    npc =
    {
    },
}

return zones[xi.zone.BATALLIA_DOWNS_S]
