-----------------------------------
-- Area: Feretory
-----------------------------------
zones = zones or {}

zones[xi.zone.FERETORY] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6387, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6395, -- Obtained: <item>.
        GIL_OBTAINED                  = 6396, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6398, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7006, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7007, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7008, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7028, -- Your party is unable to participate because certain members' levels are restricted.
        MAY_POSSESS_BEASTS            = 7343, -- You may now possess [lapinions/sheep/behemoths/elasmoths/cerebruses/orthruses]!
        THY_BRAZEN_DISREGARD          = 7362, -- Thy brazen disregard to count correctly is an affront to monipulators everywhere. Return whenas thou hast the meet amount of infamy.
        YOU_LEARNED_INSTINCT          = 7367, -- You learned <item>!
        MAY_POSSESS_BEES              = 7395, -- You may now possess bees!
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.FERETORY]
