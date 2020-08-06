-----------------------------------
-- Area: Nashmau
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.NASHMAU] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED  = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_CANNOT_BE_OBTAINEDX = 6386, -- You cannot obtain the <item>. Try trading again after sorting your inventory.
        ITEM_OBTAINED            = 6388, -- Obtained: <item>.
        GIL_OBTAINED             = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6391, -- Obtained key item: <keyitem>.
        ITEM_OBTAINEDX           = 6397, -- You obtain <number> <item>!
        FISHING_MESSAGE_OFFSET   = 7049, -- You can't fish here.
        HOMEPOINT_SET            = 7310, -- Home point set!
        NOMAD_MOOGLE_DIALOG      = 7330, -- I'm a traveling moogle, kupo. I help adventurers in the Outlands access items they have stored in a Mog House elsewhere, kupo.
        REGIME_CANCELED          = 7345, -- Current training regime canceled.
        HUNT_ACCEPTED            = 7363, -- Hunt accepted!
        USE_SCYLDS               = 7364, -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED            = 7375, -- You record your hunt.
        OBTAIN_SCYLDS            = 7377, -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED            = 7381, -- Hunt canceled.
        JAJAROON_SHOP_DIALOG     = 10479, -- Hellooo. Yooo have caaard? Can do gaaame? Jajaroon have diiice.
        TSUTSUROON_SHOP_DIALOG   = 10489, -- What yooo want? Have katana, katana, and nin-nin...yooo want?
        MAMAROON_SHOP_DIALOG     = 10492, -- Welcome to maaagic shop. Lots of magics for yooo.
        POPOROON_SHOP_DIALOG     = 10494, -- Come, come. Buy aaarmor, looots of armor!
        WATAKHAMAZOM_SHOP_DIALOG = 10495, -- Looking for some bows and bolts to strrrike fear into the hearts of your enemies? You can find 'em here!
        CHICHIROON_SHOP_DIALOG   = 10497, -- Howdy-hooo! I gots soooper rare dice for yooo.
        NENE_DELIVERY_DIALOG     = 10833, -- Yooo want to send gooods? Yooo want to send clink clink?
        NANA_DELIVERY_DIALOG     = 10834, -- Yooo send gooods. Yooo send clink clink.
        SANCTION                 = 10773, -- You have received the Empire's Sanction.
        YOYOROON_SHOP_DIALOG     = 11785, -- Boooss, boooss! Yoyoroon bring yooo goood custooomer! Yoyoroon goood wooorker, nooo?
        PIPIROON_SHOP_DIALOG     = 11786, -- Yes? I'm a busy man. Make it quick.
        RETRIEVE_DIALOG_ID       = 11886, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL    = 11923, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.NASHMAU]
