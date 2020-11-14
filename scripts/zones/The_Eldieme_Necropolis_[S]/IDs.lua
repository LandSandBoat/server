-----------------------------------
-- Area: The_Eldieme_Necropolis_[S]
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.THE_ELDIEME_NECROPOLIS_S] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6388, -- Obtained: <item>.
        GIL_OBTAINED                  = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6391, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 6999, -- You have carried over <number> points.
        LOGIN_CAMPAIGN_UNDERWAY       = 7000, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7001, -- In celebration of your most recent login no. <number>...
        LAYTON_SHOP_DIALOG            = 7103, -- Might you be a student of the same field as I? If that is the case, I might be able to provide you with the proper grimoires...at a price, of course.
        SARCOPHAGUS_SEALED            = 7597, -- It is a stone sarcophagus with the lid sealed tight. It cannot be opened.
        NAMES_CARVED_ON_STONE         = 7598, -- The names of the deceased in this area are carved upon the stone.
        YOU_CAN_NOW_BECOME_A_SCHOLAR  = 7712, -- You can now become a scholar!
        YOU_LEARN_EMBRAVA_AND_KAUSTRA = 7896, -- <name> learns Embrava and Kaustra!
        ITEM_DELIVERY_DIALOG          = 7902, -- Have something to send?
        COMMON_SENSE_SURVIVAL         = 8929, -- It appears that you have arrived at a new survival guide provided by the Servicemen's Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.THE_ELDIEME_NECROPOLIS_S]
