-----------------------------------
-- Area: Bibiki_Bay
-----------------------------------
require("scripts/globals/zone")
-----------------------------------

zones = zones or {}

zones[xi.zone.BIBIKI_BAY] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6384, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6390, -- Obtained: <item>.
        GIL_OBTAINED                  = 6391, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6393, -- Obtained key item: <keyitem>.
        YOU_OBTAIN                    = 6399, -- You obtain <number> <item>!
        NOTHING_OUT_OF_ORDINARY       = 6404, -- There is nothing out of the ordinary here.
        FELLOW_MESSAGE_OFFSET         = 6419, -- I'm ready. I suppose.
        CARRIED_OVER_POINTS           = 7001, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7002, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7003, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7023, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7057, -- Tallying conquest results...
        POHKA_SHOP_DIALOG             = 7228, -- Hey buddy, need a rod? I've got loads of state-of-the-art, top-of-the-line, high quality rods right here waitin' fer ya! Whaddya say?
        MEP_NHAPOPOLUKO_DIALOG        = 7230, -- Welcome! Fishermen's Guild representative, at your service!
        WHOA_HOLD_ON_NOW              = 7246, -- Whoa, hold on now. Ain't look like you got 'nuff room in that spiffy bag o' yours to carrrry all these darn clams. Why don't you trrry thrrrowin' some o' that old junk away before ya come back here 'gain?
        YOU_GIT_YER_BAG_READY         = 7247, -- You git yer bag ready, pardner? Well alrighty then. Here'rrre yer clams.
        YOU_RETURN_THE                = 7254, -- You return the <item>.
        AREA_IS_LITTERED              = 7255, -- The area is littered with pieces of broken seashells.
        YOU_FIND_ITEM                 = 7257, -- You find <item> and toss it into your bucket.
        THE_WEIGHT_IS_TOO_MUCH        = 7258, -- You find <item> and toss it into your bucket... But the weight is too much for the bucket and its bottom breaks! All your shellfish are washed back into the sea...
        YOU_CANNOT_COLLECT            = 7259, -- You cannot collect any clams with a broken bucket!
        IT_LOOKS_LIKE_SOMEONE         = 7260, -- It looks like someone has been digging here.
        YOUR_CLAMMING_CAPACITY        = 7268, -- Your clamming capacity has increased to <number> ponzes! Now you may be able to dig up a...
        SOMETHING_JUMPS_INTO          = 7271, -- Something jumps into your bucket and breaks through the bottom! All your shellfish are washed back into the sea...
        FISHING_MESSAGE_OFFSET        = 7272, -- You can't fish here.
        DIG_THROW_AWAY                = 7285, -- You dig up <item>, but your inventory is full. You regretfully throw the <item> away.
        FIND_NOTHING                  = 7287, -- You dig and you dig, but find nothing.
        CLUNK_CLUNK_WHIRL_WHIZZ       = 7377, -- <Clunk-clunk>... <Whirl-whizz>...!
        YOU_ARE_NOT_ALONE             = 7447, -- You are not alone!
        NO_BILLET                     = 7489, -- You were refused passage for failing to present <item>!
        HAVE_BILLET                   = 7494, -- You cannot buy morrre than one <item>. Use the one you have now to ride the next ship.
        LEFT_BILLET                   = 7499, -- You use your <item>. (<number> trip[/s] remaining)
        END_BILLET                    = 7500, -- You use up your <item>.
        NOTHING_LEFT_INTEREST         = 7617, -- There is nothing left of interest here.
        UNITY_WANTED_BATTLE_INTERACT  = 8623, -- Those who have accepted % must pay # Unity accolades to participate. The content for this Wanted battle is #. [Ready to begin?/You do not have the appropriate object set, so your rewards will be limited.]
        COMMON_SENSE_SURVIVAL         = 8645, -- It appears that you have arrived at a new survival guide provided by the Adventurers' Mutual Aid Network. Common sense dictates that you should now be able to teleport here from similar tomes throughout the world.
        NEWS_BILLET                   = 8668, -- <item> has been [added to your list of favorites/removed from your list of favorites].
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

return zones[xi.zone.BIBIKI_BAY]
