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
        KEY_BREAKS                    = 7369, -- The <item> breaks!
        PARTY_MEMBERS_HAVE_FALLEN     = 7793, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7800, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        WIDE_TRENCH                   = 7912, -- There is a wide trench around the gate here. There are three keyholes of differing sizes inside the trench.
        MINING_IS_POSSIBLE_HERE       = 7935, -- Mining is possible here if you have <item>.
        BLUE_FLAMES                   = 7974, -- You can see blue flames flickering from a hole in the ground here...
        SICKLY_SWEET                  = 8026, -- A sickly sweet fragrance pervades the air...
        THIN_LAYER_OF_CINDER          = 8033, -- The ground is carpeted in a thin layer of cinder.
        DRAWS_NEAR                    = 8048, -- Something draws near!
        DULL_PIECE                    = 8049, -- A dull piece of metal lies on the ground. It appears to be a bracelet of sorts, but the layers of grime covering its surface render it wholly unwearable.
        LIFT_LEVER                    = 8052, -- You lift the lever with all your might!
        UNITY_WANTED_BATTLE_INTERACT  = 8091, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        COMMON_SENSE_SURVIVAL         = 8113, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BIG_BOMB               = GetFirstID('Big_Bomb'),
        GURFURLUR_THE_MENACING = 17031592,
        DEXTROSE               = 17031598,
        REACTON                = 17031599,
        ACHAMOTH               = 17031600,
    },
    npc =
    {
        LEVER_AB_DOOR = 17031668,
        LEVER_CD_DOOR = 17031672,
        LEVER_EF_DOOR = 17031676,
        LEVER_GH_DOOR = 17031680,
        LEVER_IJ_DOOR = 17031684,
        MINING        = GetTableOfIDs('Mining_Point'),
    },
}

return zones[xi.zone.HALVUNG]
