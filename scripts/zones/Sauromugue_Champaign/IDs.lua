-----------------------------------
-- Area: Sauromugue_Champaign
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.SAUROMUGUE_CHAMPAIGN] =
{
    text =
    {
        NOTHING_HAPPENS          = 141,   -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED  = 6404,  -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED            = 6410,  -- Obtained: <item>.
        GIL_OBTAINED             = 6411,  -- Obtained <number> gil.
        KEYITEM_OBTAINED         = 6413,  -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY  = 6424,  -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET    = 6439,  -- I'm ready. I suppose.
        CONQUEST_BASE            = 7071,  -- Tallying conquest results...
        MANY_TIGER_BONES         = 7230,  -- There are many tiger bones here...
        OLD_SABERTOOTH_DIALOG_I  = 7236,  -- You hear the distant roar of a tiger. It sounds as if the beast is approaching slowly...
        OLD_SABERTOOTH_DIALOG_II = 7237,  -- The sound of the tiger's footsteps is growing louder.
        FISHING_MESSAGE_OFFSET   = 7238,  -- You can't fish here.
        DIG_THROW_AWAY           = 7251,  -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING             = 7253,  -- You dig and you dig, but find nothing.
        THF_AF_MOB               = 7415,  -- Something has come down from the tower!
        THF_AF_WALL_OFFSET       = 7434,  -- It is impossible to climb this wall with your bare hands.
        PLAYER_OBTAINS_ITEM      = 7497,  -- <name> obtains <item>!
        UNABLE_TO_OBTAIN_ITEM    = 7498,  -- You were unable to obtain the item.
        PLAYER_OBTAINS_TEMP_ITEM = 7499,  -- <name> obtains the temporary item: <item>!
        ALREADY_POSSESS_TEMP     = 7500,  -- You already possess that temporary item.
        NO_COMBINATION           = 7505,  -- You were unable to enter a combination.
        REGIME_REGISTERED        = 9806,  -- New training regime registered!
        COMMON_SENSE_SURVIVAL    = 12494, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        DEADLY_DODO_PH     =
        {
            [17268849] = 17268851, -- 238.000 40.000 332.000
            [17268850] = 17268851, -- 369.564 39.658 345.197
        },
        BLIGHTING_BRAND_PH =
        {
            [17269013] = 17269016, -- 240.725 1.853 223.185
        },
        OLD_SABERTOOTH     = 17268808,
        ROC                = 17269106,
        CLIMBPIX_HIGHRISE  = 17269107,
        DRIBBLIX_GREASEMAW = 17269114,
    },
    npc =
    {
        CASKET_BASE = 17269190,
        QM2         = 17269228,
    },
}

return zones[tpz.zone.SAUROMUGUE_CHAMPAIGN]
