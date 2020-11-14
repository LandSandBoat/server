-----------------------------------
-- Area: Bibiki_Bay
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[tpz.zone.BIBIKI_BAY] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED = 6382, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED           = 6388, -- Obtained: <item>.
        GIL_OBTAINED            = 6389, -- Obtained <number> gil.
        KEYITEM_OBTAINED        = 6391, -- Obtained key item: <keyitem>.
        YOU_OBTAIN              = 6397, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY = 6402, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET   = 6417, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS     = 6999, -- You have carried over <number>  points.
        LOGIN_CAMPAIGN_UNDERWAY = 7000, -- The <month> ≺year≻ Login Campaign is currently underway!
        LOGIN_NUMBER            = 7001, -- In celebration of your most recent login no. <number>...
        CONQUEST_BASE           = 7049, -- Tallying conquest results...
        POHKA_SHOP_DIALOG       = 7220, -- Hey buddy, need a rod? I've got loads of state-of-the-art, top-of-the-line, high quality rods right here waitin' fer ya! Whaddya say?
        MEP_NHAPOPOLUKO_DIALOG  = 7222, -- Welcome! Fishermen's Guild representative, at your service!
        WHOA_HOLD_ON_NOW        = 7238, -- Whoa, hold on now. Ain't look like you got 'nuff room in that spiffy bag o' yours to carrrry all these darn clams. Why don't you trrry thrrrowin' some o' that old junk away before ya come back here 'gain?
        YOU_GIT_YER_BAG_READY   = 7239, -- You git yer bag ready, pardner? Well alrighty then. Here'rrre yer clams.
        YOU_RETURN_THE          = 7246, -- You return the <item>.
        AREA_IS_LITTERED        = 7247, -- The area is littered with pieces of broken seashells.
        YOU_FIND_ITEM           = 7249, -- You find <item> and toss it into your bucket.
        THE_WEIGHT_IS_TOO_MUCH  = 7250, -- You find <item> and toss it into your bucket... But the weight is too much for the bucket and its bottom breaks! All your shellfish are washed back into the sea...
        YOU_CANNOT_COLLECT      = 7251, -- You cannot collect any clams with a broken bucket!
        IT_LOOKS_LIKE_SOMEONE   = 7252, -- It looks like someone has been digging here.
        YOUR_CLAMMING_CAPACITY  = 7260, -- Your clamming capacity has increased to <number> ponzes! Now you may be able to dig up a...
        SOMETHING_JUMPS_INTO    = 7263, -- Something jumps into your bucket and breaks through the bottom! All your shellfish are washed back into the sea...
        FISHING_MESSAGE_OFFSET  = 7264, -- You can't fish here.
        DIG_THROW_AWAY          = 7277, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING            = 7279, -- You dig and you dig, but find nothing.
        NO_BILLET               = 7481, -- You were refused passage for failing to present <item>!
        HAVE_BILLET             = 7486, -- You cannot buy morrre than one <item>. Use the one you have now to ride the next ship.
        LEFT_BILLET             = 7491, -- You use your <item>. (<number> trip[/s] remaining)
        END_BILLET              = 7492, -- You use up your <item>.
        COMMON_SENSE_SURVIVAL   = 8637, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        NEWS_BILLET             = 8660, -- <item> has been [added to your list of favorites/removed from your list of favorites].
    },
    mob =
    {
        SERRA_PH =
        {
            [16793645] = 16793646, -- -348 0.001 -904
        },
        INTULO_PH =
        {
            [16793741] = 16793742, -- 480 -3 743
        },
        SPLACKNUCK_PH =
        {
            [16793775] = 16793776,
        },
        DALHAM = 16793858,
        SHEN   = 16793859,
    },
    npc =
    {
    },
}

return zones[tpz.zone.BIBIKI_BAY]
