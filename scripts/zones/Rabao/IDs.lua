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
        ITEM_CANNOT_BE_OBTAINED = 6404, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6410, -- Obtained: <item>.
        GIL_OBTAINED            = 6411, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6413, -- Obtained key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL     = 6415, -- You do not have enough gil.
        CONQUEST_BASE           = 6499, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET  = 6658, -- You can't fish here.
        REGIME_CANCELED         = 6858, -- Current training regime canceled.
        HUNT_ACCEPTED           = 6876, -- Hunt accepted!
        USE_SCYLDS              = 6877, -- You use <number> [scyld/scylds]. Scyld balance: <number>.
        HUNT_RECORDED           = 6888, -- You record your hunt.
        OBTAIN_SCYLDS           = 6890, -- You obtain <number> [scyld/scylds]! Current balance: <number> [scyld/scylds].
        HUNT_CANCELED           = 6894, -- Hunt canceled.
        PAKHI_DELIVERY_DIALOG   = 10026, -- When your pack is fit to burrrst, send your non-essential items to your delivery box and bam, prrroblem solved!
        SPIRIT_DELIVERY_DIALOG  = 10027, -- We can deliver goods to your residence or to the residences of your friends.
        SHINY_TEETH_SHOP_DIALOG = 10031, -- Well met, adventurer. If you're looking for a weapon to carve through those desert beasts, you've come to the right place.
        BRAVEWOLF_SHOP_DIALOG   = 10032, -- For rainy days and windy days, or for days when someone tries to thrust a spear in your guts, having a good set of armor can set your mind at ease.
        BRAVEOX_SHOP_DIALOG     = 10033, -- These days, you can get weapons and armor cheap at the auction houses. But magic is expensive no matter where you go.
        SCAMPLIX_SHOP_DIALOG    = 10034, -- No problem, Scamplix not bad guy. Scamplix is good guy, sells stuff to adventurers. Scamplix got lots of good stuff for you.
        GARUDA_UNLOCKED         = 10111, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        NOMAD_MOOGLE_DIALOG     = 10179, -- I'm a traveling moogle, kupo. I help adventurers in the Outlands access items they have stored in a Mog House elsewhere, kupo.
        GENEROIT_SHOP_DIALOG    = 10297, -- Ho there! I am called Generoit. I have everything here for the chocobo enthusiast, and other rare items galore.
        RETRIEVE_DIALOG_ID      = 10753, -- You retrieve <item> from the porter moogle's care.
        COMMON_SENSE_SURVIVAL   = 11831, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
    },
    npc =
    {
    },
}

return zones[tpz.zone.RABAO]
