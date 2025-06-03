-----------------------------------
-- Area: Mhaura
-----------------------------------
zones = zones or {}

zones[xi.zone.MHAURA] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6385, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6391, -- Obtained: <item>.
        GIL_OBTAINED                  = 6392, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6394, -- Obtained key item: <keyitem>.
        NOT_HAVE_ENOUGH_GIL           = 6396, -- You do not have enough gil.
        CARRIED_OVER_POINTS           = 6430, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 6431, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 6432, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 6452, -- Your party is unable to participate because certain members' levels are restricted.
        HOMEPOINT_SET                 = 6498, -- Home point set!
        CONQUEST_BASE                 = 6556, -- Tallying conquest results...
        FISHING_MESSAGE_OFFSET        = 6732, -- You can't fish here.
        NOMAD_MOOGLE_DIALOG           = 6832, -- I'm a traveling moogle, kupo. I help adventurers in the Outlands access items they have stored in a Mog House elsewhere, kupo.
        SUBJOB_UNLOCKED               = 7073, -- You can now use support jobs!
        FERRY_ARRIVING                = 7148, -- Thank you for waiting. The ferry has arrived! Please go ahead and boarrrd!
        FERRY_DEPARTING               = 7150, -- Ferry departing!
        GRAINE_SHOP_DIALOG            = 7179, -- Hello there, I'm Graine the armorer. I've got just what you need!
        RUNITOMONITO_SHOP_DIALOG      = 7180, -- Hi! Welcome! I'm Runito-Monito, and weapons is my middle name!
        PIKINIMIKINI_SHOP_DIALOG      = 7181, -- Hi, I'm Pikini-Mikini, Mhaura's item seller. I've got the wares, so size doesn't matter!
        TYAPADOLIH_SHOP_DIALOG        = 7182, -- Welcome, strrranger! Tya Padolih's the name, and dealin' in magic is my game!
        GOLDSMITHING_GUILD            = 7183, -- Everything you need for your goldsmithing needs!
        SMITHING_GUILD                = 7184, -- Welcome to the Blacksmiths' Guild salesroom!
        RAMUH_UNLOCKED                = 7400, -- You are now able to summon [Ifrit/Titan/Leviathan/Garuda/Shiva/Ramuh].
        FYI_HERE_YOU_GO               = 7610, -- Alrrright! Here you go. Sorry that I couldn't ship it to your Mog House.
        MAURIRI_DELIVERY_DIALOG       = 7781, -- Mauriri is my name, and sending parcels from Mhaura is my game.
        PANORU_DELIVERY_DIALOG        = 7782, -- Looking for a delivery company that isn't lamey-wame? The quality of my service puts Mauriri to shame!
        DO_NOT_POSSESS                = 7784, -- You do not possess <item>. You were not permitted to board the ship...
        RETRIEVE_DIALOG_ID            = 7819, -- You retrieve <item> from the porter moogle's care.
    },
    mob =
    {
    },
    npc =
    {
        LAUGHING_BISON  = GetFirstID('Laughing_Bison'),
        EXPLORER_MOOGLE = GetFirstID('Explorer_Moogle'),
    },
}

return zones[xi.zone.MHAURA]
