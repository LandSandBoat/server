-----------------------------------
-- Area: Rabao
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.RABAO] =
{
    text =
    {
        HOMEPOINT_SET           = 2, -- Home point set!
        ITEM_CANNOT_BE_OBTAINED = 6405, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6411, -- Obtained: <item>.
        GIL_OBTAINED            = 6412, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6414, -- Obtained key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL     = 6416, -- You do not have enough gil.
        CARRIED_OVER_POINTS     = 6450, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY = 6451, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!<space>
        LOGIN_NUMBER            = 6452, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        CONQUEST_BASE           = 6500, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET  = 6659, -- You can't fish here.
        REGIME_CANCELED         = 6859, -- Current training regime canceled.
        HUNT_ACCEPTED           = 6877, -- Hunt accepted!
        USE_SCYLDS              = 6878, -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED           = 6889, -- You record your hunt.
        OBTAIN_SCYLDS           = 6891, -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED           = 6895, -- Hunt canceled.
        PAKHI_DELIVERY_DIALOG   = 10027, -- When your pack is fit to burrrst, send your non-essential items to your delivery box and bam, prrroblem solved!
        SPIRIT_DELIVERY_DIALOG  = 10028, -- We can deliver goods to your residence or to the residences of your friends.
        SHINY_TEETH_SHOP_DIALOG = 10032, -- Well met, adventurer. If you're looking for a weapon to carve through those desert beasts, you've come to the right place.
        BRAVEWOLF_SHOP_DIALOG   = 10033, -- For rainy days and windy days, or for days when someone tries to thrust a spear in your guts, having a good set of armor can set your mind at ease.
        BRAVEOX_SHOP_DIALOG     = 10034, -- These days, you can get weapons and armor cheap at the auction houses. But magic is expensive no matter where you go.
        SCAMPLIX_SHOP_DIALOG    = 10035, -- No problem, Scamplix not bad guy. Scamplix is good guy, sells stuff to adventurers. Scamplix got lots of good stuff for you.
        GARUDA_UNLOCKED         = 10112, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        NOMAD_MOOGLE_DIALOG     = 10180, -- I'm a traveling moogle, kupo. I help adventurers in the Outlands access items they have stored in a Mog House elsewhere, kupo.
        GENEROIT_SHOP_DIALOG    = 10298, -- Ho there! I am called Generoit. I have everything here for the chocobo enthusiast, and other rare items galore.
        RETRIEVE_DIALOG_ID      = 10754, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL   = 11832, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.RABAO]
