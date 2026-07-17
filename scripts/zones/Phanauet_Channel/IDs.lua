-----------------------------------
-- Area: Phanauet_Channel
-----------------------------------
zones = zones or {}

zones[xi.zone.PHANAUET_CHANNEL] =
{
    text =
    {
        ITEM_CANNOT_BE_OBTAINED       = 6386, -- You cannot obtain the <item>. Come back after sorting your inventory.
        ITEM_OBTAINED                 = 6394, -- Obtained: <item>.
        GIL_OBTAINED                  = 6395, -- Obtained <number> gil.
        KEYITEM_OBTAINED              = 6397, -- Obtained key item: <keyitem>.
        CARRIED_OVER_POINTS           = 7005, -- You have carried over <number> login point[/s].
        LOGIN_CAMPAIGN_UNDERWAY       = 7006, -- The [/January/February/March/April/May/June/July/August/September/October/November/December] <number> Login Campaign is currently underway!
        LOGIN_NUMBER                  = 7007, -- In celebration of your most recent login (login no. <number>), we have provided you with <number> points! You currently have a total of <number> points.
        MEMBERS_LEVELS_ARE_RESTRICTED = 7027, -- Your party is unable to participate because certain members' levels are restricted.
        CONQUEST_BASE                 = 7072, -- Tallying conquest results...
        TONBERRY_MSG                  = 7240, -- ...
        FISHING_MESSAGE_OFFSET        = 7241, -- You can't fish here.
        NEWTPOOL_LIZARDS              = 7359, -- These waters are crawling with nasty lizards. They seem to be attracted to the flies that skim across the surface.
        NEWTPOOL_PASSING_THROUGH      = 7360, -- We are now passing through Newtpool. I've heard rumors that an ugly blue-and-gray beast with a triangle-shaped head and four burning red eyes lurks in this forsaken place...
        NEWTPOOL_EDGE_OF_POOL         = 7361, -- We have almost arrived at the edge of the pool. There'll be less of those pesky lizards nibbling on your bait, but you will still have to be cautious.
        EMFEA_GREETING                = 7364, -- Hey, everyone. We'll be traveling the Emfea Waterway today. I'm sorry, I'm going to have to ask you to take care of any monsters that have decided to hop aboard...
        EMFEA_AMPHIBIANS              = 7365, -- Due to the close proximity of Newtpool and the abundance of insects, you will find that these waters are quite packed with tiny amphibians.
        EMFEA_NARROW_ROUTE            = 7366, -- If we turned right, we would end up on the main canal. However, today we will be taking a much narrower route.
        EMFEA_VARIETY_OF_LIFE         = 7367, -- Ah, Emfea. The variety of life in these waters does not cease to astound me. Just be careful not to reel in something deadly...
        EMFEA_DANGEROUS_BRIDGE        = 7368, -- That bridge does look awfully dangerous. I wonder if there are any plans to repair it.
        EMFEA_NEWTS_AND_FROGS         = 7369, -- This part of the canal is overrun with newts and frogs. I doubt there is even room down there for a single fish!
        EMFEA_ARRIVING_CENTRAL        = 7370, -- Ah, I see we are about to arrive at Central Landing. How time flies when taking in the lovely scenery!
        NORTH_GREETING                = 7371, -- Oh, I hope this trip doesn't take too long. My grandson in San d'Oria is waiting for me.
        NORTH_MAIN_CANAL              = 7372, -- We will be entering the main canal shortly. The last time I took this barge with my grandson, the waves were so high he almost fell into the water!
        NORTH_WATERFALL               = 7373, -- Would you look at that waterfall? My grandson named it Ineuteniace Falls. Am I not the luckiest grandfather in all the Kingdom?
        NORTH_CURRENTS_MEET           = 7374, -- Two currents meet at this spot here. The colder water from one lowers the temperature of the river, causing a change in the types of fish that can be caught.
        NORTH_CHILLY_AIR              = 7375, -- The air around here is quite chilly, is it not? I cannot wait to sit down at my daughter's table and have a sip of her delicious whitefish soup.
        NORTH_ARRIVING_NORTH          = 7376, -- Well, it looks like we have finally arrived at North Landing. I hope my grandson enjoys the trout I caught for him on the trip.
        NORTH_LINE_CAUGHT             = 7377, -- Something has caught on Ineuteniace's line!
        CENTRAL_GREETING              = 7378, -- Today we will be taking the main canal to Central Landing. I have nothing better to do, so I will be your guide.
        CENTRAL_CRISP_BREEZE          = 7379, -- Ah, feel the crisp breeze waft up off the crystal waters. I hear the fish swimming in these currents are some of the most delicious in all Vana'diel!
        CENTRAL_FORK_IN_CANAL         = 7380, -- There is a fork in the canal up ahead. We shall be using the route to the right, but I wonder where the canal would take us if we continued straight...
        CENTRAL_SCRUMPTIOUS_LIZARDS   = 7381, -- Not only fish can be caught in this area. If you are lucky, you might be able to reel in a couple of scrumptious lizards.
        CENTRAL_ARRIVING_CENTRAL      = 7382, -- Oh, it looks like we are almost to Central Landing. It has been fun, but I must hurry home and water my plants before they all dry up, kupo!
        TRAVEL_ANY_FASTER             = 7386, -- Cannot this vessel travel any faster? At my age, every minute counts!
        ARE_WE_THERE_YET              = 7387, -- <Sigh> Are we there yet?
        DREDVODD_SPAWN                = 7417, -- O-o-o-o... O-o-o-o... O-o-o...Orc!!!
        DREDVODD_DEATH                = 7418, -- <Sigh>... If it was not for your bravery, I most certainly would have reached the light at the end of that tunnel...
        NEWTPOOL_GREETING             = 7419, -- It looks like we shall be navigating the Newtpool route today. As you may already know, I am much too old to handle any excitement...
        NEWTPOOL_CONVERGE             = 7420, -- If you look closely, you can see where the main canal, the Emfea Waterway, and Newtpool converge. Breathtaking, is it not?
        NEWTPOOL_ARRIVING_SOUTH       = 7421, -- We will be arriving at South Landing shortly. I must rest a spell before continuing on my journey, though.
        RICHE_DAVOI_WATERFALL         = 7430, -- <item>...Davoi...waterfall...
    },
    mob =
    {
        GIANT_PUGIL       = GetFirstID('Giant_Pugil'),
        FLYTRAP           = GetTableOfIDs('Flytrap'),
        OOZE              = GetFirstID('Ooze'),
        STUBBORN_DREDVODD = GetFirstID('Stubborn_Dredvodd'),
        VODYANOI          = GetFirstID('Vodyanoi'),
    },
    npc =
    {
        TIMEKEEPER_OFFSET = GetFirstID('Ineuteniace'),
        TONBERRY_OFFSET   = GetFirstID('Riche'),
        RIDER_OFFSET      = GetFirstID('Laiteconce'),
    },
}

return zones[xi.zone.PHANAUET_CHANNEL]
