-----------------------------------
-- Area: Arrapago_Reef
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.ARRAPAGO_REEF] =
{
    text =
    {
        NOTHING_HAPPENS               = 119,  -- Nothing happens...
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        FISHING_MESSAGE_OFFSET        = 7054, -- You can't fish here.
        STAGING_GATE_CLOSER           = 7314, -- You must move closer.
        STAGING_GATE_INTERACT         = 7315, -- This gate guards an area under Imperial control.
        STAGING_GATE_ILRUSI           = 7320, -- Ilrusi Atoll Staging Point.
        CANNOT_LEAVE                  = 7325, -- You cannot leave this area while in the possession of <keyitem>.
        RESPONSE                      = 7334, -- There is no response...
        DOOR_IS_LOCKED                = 7463, -- The door is locked.  You might be able to open it with <item>.
        DOOR_IS_LOCKED2               = 7464, -- The door is locked.  You might be able to open it with <item> or <item>.
        KEY_BREAKS                    = 7465, -- The <item> breaks!
        YOU_UNLOCK_DOOR               = 7468, -- You unlock the door from the inside.
        LOCK_SUCCESS                  = 7469, -- <name> successfully opened the lock with the <item>!
        LOCK_FAIL                     = 7470, -- <name> failed to open the lock with the <item>...
        PARTY_MEMBERS_HAVE_FALLEN     = 7889, -- All party members have fallen in battle. Now leaving the battlefield.
        THE_PARTY_WILL_BE_REMOVED     = 7896, -- If all party members' HP are still zero after # minute[/s], the party will be removed from the battlefield.
        YOU_NO_REQS                   = 7900, -- You do not meet the requirements to enter the battlefield with your party members. Access is denied.
        YOUR_IMPERIAL_STANDING        = 7914, -- Your Imperial Standing has increased!
        HAND_OVER_TO_IMMORTAL         = 8432, -- You hand over the % to the Immortal.
        CANNOT_ENTER                  = 8451, -- You cannot enter at this time. Please wait a while before trying again.
        AREA_FULL                     = 8452, -- This area is fully occupied. You were unable to enter.
        MEMBER_NO_REQS                = 8456, -- Not all of your party members meet the requirements for this objective. Unable to enter area.
        MEMBER_TOO_FAR                = 8460, -- One or more party members are too far away from the entrance. Unable to enter area.
        MEDUSA_ENGAGE                 = 8562, -- Foolish two-legs... Have you forgotten the terrible power of the gorgons you created? It is time you were reminded...
        MEDUSA_DEATH                  = 8563, -- No... I cannot leave my sisters...
        GLITTERING_FRAGMENTS          = 8886, -- Minute glittering fragments are scattered all over...
        STIFLING_STENCH               = 8899, -- A stifling stench pervades the air...
        SLIMY_TOUCH                   = 8904, -- The ground here is slimy to the touch...
        FLUTTERY_OBJECTS              = 8910, -- Light, fluttery objects litter the ground...
        DRAWS_NEAR                    = 8915, -- Something draws near!
        COMMON_SENSE_SURVIVAL         = 9786, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
    },
    mob =
    {
        BLOODY_BONES_PH =
        {
            [16998653] = 16998655, -- 136.234 -6.831 468.779
        },
        MEDUSA                = DYNAMIC_LOOKUP,
        LIL_APKALLU           = DYNAMIC_LOOKUP,
        VELIONIS              = DYNAMIC_LOOKUP,
        ZAREEHKL_THE_JUBILANT = DYNAMIC_LOOKUP,
        NUHN                  = DYNAMIC_LOOKUP,
    },
    npc =
    {
    },
}

return zones[xi.zone.ARRAPAGO_REEF]
