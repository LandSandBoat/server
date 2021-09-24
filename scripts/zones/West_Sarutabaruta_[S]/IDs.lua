-----------------------------------
-- Area: West_Sarutabaruta_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.WEST_SARUTABARUTA_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED     = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED               = 6389, -- Obtained: <item>.
        GIL_OBTAINED                = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED            = 6392, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS         = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY     = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        HARVESTING_IS_POSSIBLE_HERE = 7073, -- Harvesting is possible here if you have <item>.
        FISHING_MESSAGE_OFFSET      = 7080, -- You can't fish here.
        DOOR_OFFSET                 = 7438, -- The door is sealed shut...
        VOIDWALKER_DESPAWN          = 7964, -- The monster fades before your eyes, a look of disappointment on its face.
        VOIDWALKER_NO_MOB           = 8362, -- The <keyitem> quivers ever so slightly, but emits no light. There seem to be no monsters in the area.
        VOIDWALKER_MOB_TOO_FAR      = 8363, -- The <keyitem> quivers ever so slightly and emits a faint light. There seem to be no monsters in the immediate vicinity.
        VOIDWALKER_MOB_HINT         = 8364, -- The <keyitem> resonates [feebly/softly/solidly/strongly/very strongly/furiously], sending a radiant beam of light lancing towards a spot roughly <number> [yalm/yalms] [east/southeast/south/southwest/west/northwest/north/northeast] of here.
        VOIDWALKER_SPAWN_MOB        = 8365, -- A monster materializes out of nowhere!
        VOIDWALKER_UPGRADE_KI_1     = 8367, -- The <keyitem> takes on a slightly deeper hue and becomes <keyitem>!
        VOIDWALKER_UPGRADE_KI_2     = 8368, -- The <keyitem> takes on a deeper, richer hue and becomes <keyitem>!
        VOIDWALKER_BREAK_KI         = 8369, -- The <keyitem> shatters into tiny fragments.
        VOIDWALKER_OBTAIN_KI        = 8370, -- Obtained key item: <keyitem>!
        COMMON_SENSE_SURVIVAL       = 9262, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        JEDUAH_PH =
        {
            [17166542] = 17166543, -- 113.797 -0.8 -310.342
        },
        RAMPONNEAU_PH =
        {
            [17166701] = 17166705, -- 78.836 -0.109 -199.204
        },
        VOIDWALKER        =
        {
            [xi.keyItem.CLEAR_ABYSSITE] = {
                17166778, -- Raker bee
                17166777, -- Raker bee
                17166776, -- Raker bee
                17166775, -- Raker bee
                17166774,  -- Rummager beetle
                17166773,  -- Rummager beetle
                17166772,  -- Rummager beetle
                17166771,  -- Rummager beetle
            },
            [xi.keyItem.COLORFUL_ABYSSITE] = {
                17166770,  -- Jyeshtha
                17166769, -- Farruca Fly
            },
            [xi.keyItem.BROWN_ABYSSITE] = {
                17166768  -- Orcus
            },
            [xi.keyItem.BLACK_ABYSSITE] = {
                17166767  -- Yilbegan
            }
        }
    },
    npc =
    {
        HARVESTING =
        {
            17167162,
            17167163,
            17167164,
            17167165,
            17167166,
            17167167,
        },
    },
}

return zones[xi.zone.WEST_SARUTABARUTA_S]
