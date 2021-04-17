-----------------------------------
-- Area: Nashmau
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.NASHMAU] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED  = 6383, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_CANNOT_BE_OBTAINEDX = 6387, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED            = 6389, -- Obtained: <item>.
        GIL_OBTAINED             = 6390, -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6392, -- Obtained key item: <keyitem>.
        ITEM_OBTAINEDX           = 6398, -- You obtain <number> <item>!
        CARRIED_OVER_POINTS      = 7000, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY  = 7001, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER             = 7002, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        FISHING_MESSAGE_OFFSET   = 7050, -- You can't fish here.
        HOMEPOINT_SET            = 7311, -- Home point set!
        NOMAD_MOOGLE_DIALOG      = 7331, -- I'm a traveling moogle, kupo. I help adventurers in the Outlands access items they have stored in a Mog House elsewhere, kupo.
        REGIME_CANCELED          = 7346, -- Current training regime canceled.
        HUNT_ACCEPTED            = 7364, -- Hunt accepted!
        USE_SCYLDS               = 7365, -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED            = 7376, -- You record your hunt.
        OBTAIN_SCYLDS            = 7378, -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED            = 7382, -- Hunt canceled.
        JAJAROON_SHOP_DIALOG     = 10480, -- Hellooo. Yooo have caaard? Can do gaaame? Jajaroon have diiice.
        TSUTSUROON_SHOP_DIALOG   = 10490, -- What yooo want? Have katana, katana, and nin-nin...yooo want?
        MAMAROON_SHOP_DIALOG     = 10493, -- Welcome to maaagic shop. Lots of magics for yooo.
        POPOROON_SHOP_DIALOG     = 10495, -- Come, come. Buy aaarmor, looots of armor!
        WATAKHAMAZOM_SHOP_DIALOG = 10496, -- Looking for some bows and bolts to strrrike fear into the hearts of your enemies? You can find 'em here!
        CHICHIROON_SHOP_DIALOG   = 10498, -- Howdy-hooo! I gots soooper rare dice for yooo.
        NENE_DELIVERY_DIALOG     = 10834, -- Yooo want to send gooods? Yooo want to send clink clink?
        NANA_DELIVERY_DIALOG     = 10835, -- Yooo send gooods. Yooo send clink clink.
        SANCTION                 = 10774, -- You have received the Empire's Sanction.
        YOYOROON_SHOP_DIALOG     = 11786, -- Boooss, boooss! Yoyoroon bring yooo goood custooomer! Yoyoroon goood wooorker, nooo?
        PIPIROON_SHOP_DIALOG     = 11787, -- Yes? I'm a busy man. Make it quick.
        RETRIEVE_DIALOG_ID       = 11887, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL    = 11924, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[xi.zone.NASHMAU]
