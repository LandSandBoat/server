-----------------------------------
-- Area: Attohwa_Chasm
-----------------------------------
zones = zones or {}

zones[xi.zone.ATTOHWA_CHASM] =
{
    text =
    {
        CANNOT_OBTAIN_ITEM            = 6385, -- You cannot obtain the <item>.
        ITEM_CANNOT_BE_OBTAINED       = 6387, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395, -- Obtained: <item>.
        GIL_OBTAINED                  = 6396, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398, -- Obtained key item: <keyitem>.
        KEYITEM_LOST                  = 6399, -- Lost key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6409, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6424, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7073, -- Tallying conquest results...
        MINING_IS_POSSIBLE_HERE       = 7232, -- Mining is possible here if you have <item>.
        MIMEO_STONE_PICKUP            = 7340, -- The <keyitem> is shining brilliantly.
        MIMEO_JEWEL_OFFSET            = 7341, -- The light from the <keyitem> is beginning to fade.
        MIMEO_STONE_BRIGHTNESS_OFFSET = 7346, -- The <keyitem> is shining brilliantly.
        MUST_MOVE_CLOSER              = 7351, -- You must move a little closer to examine the area.
        GASPONIA_POISON               = 7353, -- The poison of the Gasponia has begun to spread through your body.
        OCCASIONAL_LUMPS              = 7368, -- Occasionally lumps arise in the ground here, then settle down again. It seems that there is something beneath the earth.
        HOMEPOINT_SET                 = 8255, -- Home point set!
        UNITY_WANTED_BATTLE_INTERACT  = 8313, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
    },
    mob =
    {
        LIOUMERE            = GetFirstID('Lioumere'),
        CITIPATI            = GetFirstID('Citipati'),
        TIAMAT              = GetFirstID('Tiamat'),
        FEELER_ANTLION      = GetFirstID('Feeler_Antlion'),
        AMBUSHER_ANTLION    = GetFirstID('Ambusher_Antlion'),
        ALASTOR_ANTLION     = GetFirstID('Alastor_Antlion'),
        EXECUTIONER_ANTLION = GetTableOfIDs('Executioner_Antlion'),
        XOLOTL              = GetFirstID('Xolotl'),
    },
    npc =
    {
        MIASMA_OFFSET     = GetFirstID('_071'),
        GASPONIA_OFFSET   = GetFirstID('_07n'),
        EXCAVATION        = GetTableOfIDs('Excavation_Point'),
        QM_FEELER_ANTLION = GetFirstID('qm_feeler_antlion'),
        LUMINANT          = GetTableOfIDs('Luminant'),
    },
}

return zones[xi.zone.ATTOHWA_CHASM]
