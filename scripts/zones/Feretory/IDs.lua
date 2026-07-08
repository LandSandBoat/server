-----------------------------------
-- Area: Feretory
-----------------------------------
zones = zones or {}

zones[xi.zone.FERETORY] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        MAY_POSSESS_BEASTS            = 7342, -- You may now possess [lapinions/sheep/behemoths/elasmoths/cerebruses/orthruses]!
        THY_BRAZEN_DISREGARD          = 7361, -- Thy brazen disregard to count correctly is an affront to monipulators everywhere. Return whenas thou hast the meet amount of infamy.
        YOU_LEARNED_INSTINCT          = 7366, -- You learned <item>!
        MAY_POSSESS_BEES              = 7394, -- You may now possess bees!
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.FERETORY]
