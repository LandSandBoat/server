-----------------------------------
-- Area: Halvung
-----------------------------------
zones = zones or {}

zones[xi.zone.HALVUNG] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        KEY_BREAKS                    = 7372, -- The <item> breaks!
        PARTY_MEMBERS_HAVE_FALLEN     = 7796, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7803, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        WIDE_TRENCH                   = 7915, -- There is a wide trench around the gate here. There are three keyholes of differing sizes inside the trench.
        MINING_IS_POSSIBLE_HERE       = 7938, -- Mining is possible here if you have <item>.
        BLUE_FLAMES                   = 7977, -- You can see blue flames flickering from a hole in the ground here...
        SICKLY_SWEET                  = 8029, -- A sickly sweet fragrance pervades the air...
        THIN_LAYER_OF_CINDER          = 8036, -- The ground is carpeted in a thin layer of cinder.
        DRAWS_NEAR                    = 8051, -- Something draws near!
        DULL_PIECE                    = 8052, -- A dull piece of metal lies on the ground. It appears to be a bracelet of sorts, but the layers of grime covering its surface render it wholly unwearable.
        LIFT_LEVER                    = 8055, -- You lift the lever with all your might!
        UNITY_WANTED_BATTLE_INTERACT  = 8094, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        COMMON_SENSE_SURVIVAL         = 8116, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        WAMOURA_OFFSET         = GetTableOfIDs('Wamoura'),
        BIG_BOMB               = GetFirstID('Big_Bomb'),
        GURFURLUR_THE_MENACING = GetFirstID('Gurfurlur_the_Menacing'),
        DEXTROSE               = GetFirstID('Dextrose'),
        REACTON                = GetFirstID('Reacton'),
        ACHAMOTH               = GetFirstID('Achamoth'),
    },
    npc =
    {
        LEVER_AB_DOOR = GetFirstID('_1qf'),
        LEVER_CD_DOOR = GetFirstID('_1qh'),
        LEVER_EF_DOOR = GetFirstID('_1qj'),
        LEVER_GH_DOOR = GetFirstID('_1ql'),
        LEVER_IJ_DOOR = GetFirstID('_1qn'),
        MINING        = GetTableOfIDs('Mining_Point'),
    },
}

return zones[xi.zone.HALVUNG]
