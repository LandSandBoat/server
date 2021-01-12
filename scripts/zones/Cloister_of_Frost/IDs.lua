-----------------------------------
-- Area: Cloister_of_Frost
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.CLOISTER_OF_FROST] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED          = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                    = 6389, -- Obtained: <item>.
        GIL_OBTAINED                     = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED                 = 6392, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS              = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY          = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                     = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE                    = 7050, -- Tallying conquest results...
        YOU_CANNOT_ENTER_THE_BATTLEFIELD = 7211, -- You cannot enter the battlefield at present. Please wait a little longer.
        PROTOCRYSTAL                     = 7235, -- It is a giant crystal.
        SHIVA_UNLOCKED                   = 7569, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        CANNOT_REMOVE_FRAG               = 7663, -- It is an oddly shaped stone monument. A shining stone is embedded in it, but cannot be removed...
        ALREADY_OBTAINED_FRAG            = 7664, -- You have already obtained this monument's <keyitem>. Try searching for another.
        ALREADY_HAVE_ALL_FRAGS           = 7665, -- You have obtained all of the fragments. You must hurry to the ruins of the ancient shrine!
        FOUND_ALL_FRAGS                  = 7666, -- You have obtained <keyitem>! You now have all 8 fragments of light!
        ZILART_MONUMENT                  = 7667, -- It is an ancient Zilart monument.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.CLOISTER_OF_FROST]
