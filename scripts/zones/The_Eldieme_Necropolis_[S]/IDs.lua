-----------------------------------
-- Area: The_Eldieme_Necropolis_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.THE_ELDIEME_NECROPOLIS_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6389, -- Obtained: <item>.
        GIL_OBTAINED                  = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6392, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER                  = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        LAYTON_SHOP_DIALOG            = 7107, -- Might you be a student of the same field as I? If that is the case, I might be able to provide you with the proper grimoires...at a price, of course.
        SARCOPHAGUS_SEALED            = 7601, -- It is a stone sarcophagus with the lid sealed tight. It cannot be opened.
        NAMES_CARVED_ON_STONE         = 7602, -- The names of the deceased in this area are carved upon the stone.
        YOU_CAN_NOW_BECOME_A_SCHOLAR  = 7716, -- You can now become a scholar!
        YOU_LEARN_EMBRAVA_AND_KAUSTRA = 7900, -- <name> learns Embrava and Kaustra!
        ITEM_DELIVERY_DIALOG          = 7906, -- Have something to send?
        COMMON_SENSE_SURVIVAL         = 8933, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.THE_ELDIEME_NECROPOLIS_S]
