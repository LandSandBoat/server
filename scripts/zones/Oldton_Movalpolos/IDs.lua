-----------------------------------
-- Area: Oldton_Movalpolos
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.OLDTON_MOVALPOLOS] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        FELLOW_MESSAGE_OFFSET         = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7060, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 7579, -- You can't fish here.
        NOTHING_OUT_OF_ORDINARY       = 7689, -- There is nothing out of the ordinary here.
        MINING_IS_POSSIBLE_HERE       = 7710, -- Mining is possible here if you have <item>.
        BRAKOBRIK_1                   = 7718, -- Stupid people. You don't getting what I'm saying.
        BRAKOBRIK_2                   = 7722, -- Killing bombs. Bringing *item*
        BRAKOBRIK_3                   = 7727, -- Good, good. You being smart. Very, very clever.
        BRAKOBRIK_4                   = 7730, -- When Brakobrik realizes that you already possess the item he is trying to give you, he refuses to give you another one.
        RAKOROK_DIALOGUE              = 7734, -- Nsy pipul. Gattohre! I bisynw!
        ALTANA_DIE                    = 7736, -- Aaaltaaanaaa...Diiieee!!!
        MONSTER_APPEARED              = 7749, -- A monster has appeared!
        CHEST_UNLOCKED                = 7758, -- You unlock the chest!
        RUSTY_IRON_BOX                = 8057, -- There is a rusty iron box with strange markings and a narrow slit on the lid.
        RECOMMENDATION_LETTER         = 8058, -- You slip the recommendation letter through the opening on the lid of the box.
        COMMON_SENSE_SURVIVAL         = 8116, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BUGBEAR_STRONGMAN_PH  =
        {
            [16822421] = 16822423, -- -81.31 31.493 210.675 (west)
            [16822426] = 16822427, -- 58.013, 15.5, -121.928 (east)
        },
        GOBLIN_WOLFMAN               = 16822459,
        BUGALLUG                     = 16822456,
        GOBLIN_PRECEPTOR             = 16822460,
        GRIMOIRE_GURU_GRIMOGEK       = 16822461,
        DREAD_DEALING_DREDODAK       = 16822462,
        BUGBEAR_PORTERMAN1           = 16822463,
        BUGBEAR_PORTERMAN2           = 16822464,
        BUGBEAR_PORTERMAN3           = 16822465,
        BUGBEAR_PORTERMAN4           = 16822466,
    },
    npc =
    {
        SCRAWLED_WRITING = 16822469,
        OVERSEER_BASE    = 16822509, -- first Conquest_Banner in npc_list
        TREASURE_CHEST   = 16822531,
        IRON_BOX         = 16822544,
        MINING =
        {
            16822525,
            16822526,
            16822527,
            16822528,
            16822529,
            16822530,
        },
    },
}

return zones[xi.zone.OLDTON_MOVALPOLOS]
