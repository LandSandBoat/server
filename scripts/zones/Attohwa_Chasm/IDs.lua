-----------------------------------
-- Area: Attohwa_Chasm
-----------------------------------
zones = zones or {}

zones[xi.zone.ATTOHWA_CHASM] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6394, -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7064, -- Tallying conquest results...
        MINING_IS_POSSIBLE_HERE       = 7223, -- Mining is possible here if you have <item>.
        MIMEO_JEWEL_OFFSET            = 7331, -- The light from the <keyitem> is beginning to fade.
        MUST_MOVE_CLOSER              = 7341, -- You must move a little closer to examine the area.
        GASPONIA_POISON               = 7343, -- The poison of the Gasponia has begun to spread through your body.
        OCCASIONAL_LUMPS              = 7358, -- Occasionally lumps arise in the ground here, then settle down again. It seems that there is something beneath the earth.
        HOMEPOINT_SET                 = 8245, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 8303, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        LIOUMERE         = GetFirstID('Lioumere'),
        CITIPATI         = GetFirstID('Citipati'),
        TIAMAT           = GetFirstID('Tiamat'),
        FEELER_ANTLION   = GetFirstID('Feeler_Antlion'),
        AMBUSHER_ANTLION = GetFirstID('Ambusher_Antlion'),
    },
    npc =
    {
        MIASMA_OFFSET   = GetFirstID('_071'),
        GASPONIA_OFFSET = GetFirstID('_07n'),
        EXCAVATION      = GetTableOfIDs('Excavation_Point'),
    },
}

return zones[xi.zone.ATTOHWA_CHASM]
