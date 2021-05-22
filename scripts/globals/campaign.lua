----------------------------------------
-- Campaign global
----------------------------------------
require("scripts/globals/teleports")
require("scripts/globals/zone")
require("scripts/globals/status")
----------------------------------------
xi = xi or {}
xi.campaign = {}

xi.campaign.control =
{
    Sandoria = 2,
    Bastok = 4,
    Windurst = 6,
    Beastman = 8,
}

xi.campaign.union =
{
    Adder = 1,
    Bison = 2,
    Coyote = 3,
    Dhole = 4,
	Eland = 5,
}

xi.campaign.army =
{
    Sandoria = 0,
    Bastok = 1,
    Windurst = 2,
    Orcish = 3,
    Quadav = 4,
    Yagudo = 5,
    Kindred = 6,
}

xi.campaign.zone =
{
    SouthernSandOria = 80,
    EastRonfaure = 81,
    JugnerForest = 82,
    VunkerlInlet = 83,
    BatalliaDowns = 84,
    LaVaule = 85,
    TheEldiemeNecropolis = 175,
    BastokMarkets = 87,
    NorthGustaberg = 88,
    Grauberg = 89,
    PashhowMarshlands = 90,
    RolanberryFields = 91,
    Beadeaux = 92,
    CrawlersNest = 171,
    WindurstWaters = 94,
    WestSarutabaruta = 95,
    FortKarugoNarugo = 96,
    MeriphataudMountains = 97,
    SauromugueChampaign = 98,
    CastleOztroja = 99,
    GarlaigeCitadel = 164,
    BeaucedineGlacier = 136,
    Xarcabard = 137,
    CastleZvahlBaileys = 138,
    CastleZvahlKeep = 155,
    ThroneRoom = 156,
}

xi.campaign.initZone = function(zone)
	zone:setLocalVar("DayMusic", zone:getBackgroundMusicDay())
	zone:setLocalVar("NightMusic", zone:getBackgroundMusicNight())
	zone:setLocalVar("SoloMusic", zone:getSoloBattleMusic())
	zone:setLocalVar("PartyMusic", zone:getPartyBattleMusic())
	if(zone:getCampaignBattleStatus()) then
		zone:setBackgroundMusicDay(247)
		zone:setBackgroundMusicNight(247)
		zone:setSoloBattleMusic(247)
		zone:setPartyBattleMusic(247)
	end
end

-----------------------------------------------------------------
-- Returns the battle flag for the zone
-- zone: xi.campaign.zone
-- Return: 1 or 0
-----------------------------------------------------------------
xi.campaign.getBattleStatus = function(zone)
    return zone:getCampaignBattleStatus()
end

-----------------------------------------------------------------
-- Sets the battle flag for the zone
-- zone: xi.campaign.zone
-- status: 1 or 0
-----------------------------------------------------------------
xi.campaign.setBattleStatus = function(zone, status)
    zone:setCampaignBattleStatus(status)
end


-----------------------------------------------------------------
-- Returns the heroism value for the zone
-- zone: xi.campaign.zone
-- amount: 0 to 200 [retail max is unknown]
-----------------------------------------------------------------
xi.campaign.getHeroism = function(zone)
    return zone:getCampaignHeroism()
end

-----------------------------------------------------------------
-- Modifies the heroism value by the amount for the zone
-- zone: xi.campaign.zone
-- amount: 0 to 200 [retail max is unknown]
-----------------------------------------------------------------
xi.campaign.setHeroism = function(zone, amount)
    zone:setCampaignHeroism(amount)
end


-----------------------------------------------------------------
-- Returns the xi.campaign.control value for the zone
-- zone: xi.campaign.zone
-- Return: xi.campaign.control
-----------------------------------------------------------------
xi.campaign.getZoneControl = function(zone)
    return zone:getCampaignZoneControl()
end

-----------------------------------------------------------------
-- Modifies the fortification value by the amount for the zone
-- zone: xi.campaign.zone
-- control: xi.campaign.control
-----------------------------------------------------------------
xi.campaign.setZoneControl = function(zone, control)
    zone:setCampaignZoneControl(control)
end

-----------------------------------------------------------------
-- Returns the fortification value for the zone
-- zone: xi.campaign.zone
-- amount: 0 to 1023 [retail max is unknown]
-----------------------------------------------------------------
xi.campaign.getFortification = function(zone)
    zone:getCampaignFortification()
end

-----------------------------------------------------------------
-- Modifies the fortification value by the amount for the zone
-- zone: xi.campaign.zone
-- amount: 0 to 1023 [retail max is unknown]
-----------------------------------------------------------------
xi.campaign.setFortification = function(zone, amount)
    zone:setCampaignFortification(amount)
end

-----------------------------------------------------------------
-- Returns the max fortification value for the zone
-- zone: xi.campaign.zone
-- amount: 0 to 1023 [retail max is unknown]
-----------------------------------------------------------------
xi.campaign.getMaxFortification = function(zone)
    zone:getCampaignMaxFortification()
end

-----------------------------------------------------------------
-- Modifies the max fortification value by the amount for the zone
-- zone: xi.campaign.zone
-- amount: -1000 to 1000 [retail max is unknown]
-----------------------------------------------------------------
xi.campaign.setMaxFortification = function(zone, amount)
    zone:setCampaignMaxFortification(amount)
end

-----------------------------------------------------------------
-- Returns the resource value for the zone
-- zone: xi.campaign.zone
-- amount: 0 to 1023 [retail max is unknown]
-----------------------------------------------------------------
xi.campaign.getResource = function(zone)
    zone:getCampaignResource()
end

-----------------------------------------------------------------
-- Modifies the resource value by the amount for the zone
-- zone: xi.campaign.zone
-- amount: -1000 to 1000 [retail max is unknown]
-----------------------------------------------------------------
xi.campaign.setResource = function(zone, amount)
    zone:setCampaignResource(amount)
end

-----------------------------------------------------------------
-- Returns the resource value for the zone
-- zone: xi.campaign.zone
-- amount: 0 to 1023 [retail max is unknown]
-----------------------------------------------------------------
xi.campaign.getMaxResource = function(zone)
    zone:getCampaignMaxResource()
end

-----------------------------------------------------------------
-- Modifies the max resource value by the amount for the zone
-- zone: xi.campaign.zone
-- amount: -1000 to 1000 [retail max is unknown]
-----------------------------------------------------------------
xi.campaign.setMaxResource = function(zone, amount)
    zone:setCampaignMaxResource(amount)
end

-----------------------------------------------------------------
-- Returns the army's influence value for the zone
-- army: xi.campaign.army
-- zone: xi.campaign.zone
-- amount: 0 to 250
-----------------------------------------------------------------
xi.campaign.getInfluence = function(zone, army)
    zone:getCampaignInfluence(army)
end

-----------------------------------------------------------------
-- Modifies the army's influence value by the amount for the zone
-- army: xi.campaign.army
-- zone: xi.campaign.zone
-- amount: -250 to 250
-----------------------------------------------------------------
xi.campaign.setInfluence = function(zone, army, amount)
    zone:setCampaignInfluence(army, amount)
end

-----------------------------------------------------------------
-- Returns the army's reconnaissance value
-- army: xi.campaign.army
-- amount: 0 to 10
-----------------------------------------------------------------
xi.campaign.getReconnaissance = function(zone, army)
    zone:getCampaignReconnaissance(army)
end

-----------------------------------------------------------------
-- Modifies the army's reconnaissance value by the amount
-- army: xi.campaign.army
-- amount: 0 to 10
-----------------------------------------------------------------
xi.campaign.setReconnaissance = function(zone, army, amount)
    zone:setCampaignReconnaissance(army, amount)
end


-----------------------------------------------------------------
-- Return the army's morale value
-- army: xi.campaign.army
-- amount: 0 to 100
-----------------------------------------------------------------
xi.campaign.getMorale = function(zone, army)
    zone:getCampaignMorale(army)
end

-----------------------------------------------------------------
-- Modifies the army's morale value by the amount
-- army: xi.campaign.army
-- amount: 0 to 100
-----------------------------------------------------------------
xi.campaign.setMorale = function(zone, army, amount)
    zone:setCampaignMorale(army, amount)
end


-----------------------------------------------------------------
-- Returns the army's prosperity value
-- army: xi.campaign.army
-- amount: 0 to 100
-----------------------------------------------------------------
xi.campaign.getProsperity = function(zone, army)
    zone:getCampaignProsperity(army)
end

-----------------------------------------------------------------
-- Modifies the army's prosperity value by the amount
-- army: xi.campaign.army
-- amount: 0 to 100
-----------------------------------------------------------------
xi.campaign.setProsperity = function(zone, army, amount)
    zone:setCampaignProsperity(army, amount)
end


-----------------------------------------------------------------
-- Returns the zone's union count
-- army: xi.campaign.union
-- amount: 0 to 50
-----------------------------------------------------------------
xi.campaign.getUnionCount = function(zone, union)
    return zone:getCampaignUnionCount(union)
end

-----------------------------------------------------------------
-- Modifies the zone's union count by the amount
-- army: xi.campaign.union
-- amount: 0 to 50
-----------------------------------------------------------------
xi.campaign.setUnionCount = function(zone, union, amount)
    zone:setCampaignUnionCount(union, amount)
end

-----------------------------------------------------------------
-- Variable for getNationTeleport and getPoint
-----------------------------------------------------------------

ALLIED_NOTES = 11
MAW = 4
PAST_SANDORIA = 5
PAST_BASTOK = 6
PAST_WINDURST = 7

-- -------------------------------------------------------------------
-- getMedalRank()
-- Returns the numerical Campaign Medal of the player.
-- -------------------------------------------------------------------

function getMedalRank(player)
    local rank = 0
    local medals =
    {
         924, 925, 926, 927, 928, 929, 930,
         931, 932, 933, 934, 935, 936, 937,
         938, 939, 940, 941, 942, 943
    }
    while (player:hasKeyItem(medals[rank + 1]) == true) do
        rank = rank + 1
    end
    return rank
end

-- -------------------------------------------------------------------
-- get[nation]NotesItem()
-- Returns the item ID and cost of the Allied Notes indexed item
-- (the same value as that used by the vendor event)
-- Format:
-- ListName_AN_item[optionID] = itemID -- ItemName
-- ListName_AN_price[optionID] = cost -- ItemName
-- -------------------------------------------------------------------

function getSandOriaNotesItem(i)
    local SandOria_AN =
    {
        [2] = {id = 15754, price = 980}, -- Sprinter's Shoes
        [258] = {id = 5428, price = 10}, -- Scroll of Instant Retrace
        [514] = {id = 14584, price = 1500}, -- Iron Ram jack coat
        [770] = {id = 14587, price = 1500}, -- Pilgrim Tunica
        [1026] = {id = 16172, price = 4500}, -- Iron Ram Shield
        [1282] = {id = 15841, price = 5000}, -- Recall Ring: Jugner
        [1538] = {id = 15842, price = 5000}, -- Recall Ring: Pashhow
        [1794] = {id = 15843, price = 5000}, -- Recall Ring: Meriphataud
        [2050] = {id = 10116, price = 2000}, -- Cipher: Valaineral
        -- Stars Service
        [18] = {id = 14581, price = 15000}, -- Iron Ram Chainmain
        [274] = {id = 15005, price = 10500}, -- Iron Ram Mufflers
        [530] = {id = 15749, price = 10500}, -- Iron Ram Sollerets
        [786] = {id = 16141, price = 10500}, -- Iron Ram Helm
        [1042] = {id = 16312, price = 10500}, -- Iron Ram Breeches
        -- Emblems Service
        [34] = {id = 16312, price = 30000}, -- Iron Ram Horn
        [290] = {id = 16312, price = 30000}, -- Iron Ram Lance
        [546] = {id = 16312, price = 30000}, -- Iron Ram Pick
        [802] = {id = 16312, price = 60000}, -- Iron Ram Sallet
        [1058] = {id = 16312, price = 60000}, -- Iron Ram Dastanas
        -- Wings Service
        [50] = {id = 15755, price = 75000}, -- Iron Ram Greaves
        [306] = {id = 16315, price = 75000}, -- Iron Ram Hose
        -- Medals Service
        [66] = {id = 15844, price = 45000}, -- Patronus Ring
        [322] = {id = 15966, price = 45000}, -- Fox Earring
        [578] = {id = 15961, price = 45000}, -- Temple Earring
        [834] = {id = 15934, price = 45000}, -- Crimson Belt
        [1090] = {id = 19041, price = 45000}, -- Rose Strap
        [1346] = {id = 15488, price = 112500}, -- Iron Ram Hauberk
        [1602] = {id = 11356, price = 15000}, -- Royal Guard Livery
        -- Medal of Altana
        [82] = {id = 17684, price = 150000}, -- Griffinclaw
        [338] = {id = 11636, price = 75000} -- Royal Knight Sigil Ring
    }
    local item = SandOria_AN[i]
    return item.id, item.price
end

function getBastokNotesItem(i)
    local Bastok_AN =
    {
        [2] = {id = 15754, price = 980}, -- Sprinter's Shoes
        [258] = {id = 5428, price = 10}, -- Scroll of Instant Retrace
        [514] = {id = 14585, price = 1500}, -- Fourth Tunica
        [770] = {id = 14587, price = 1500}, -- Pilgrim Tunica
        [1026] = {id = 18727, price = 4500}, -- Fourth Gun
        [1282] = {id = 15841, price = 5000}, -- Recall Ring: Jugner
        [1538] = {id = 15842, price = 5000}, -- Recall Ring: Pashhow
        [1794] = {id = 15843, price = 5000}, -- Recall Ring: Meriphataud
        [2050] = {id = 10116, price = 2000}, -- Cipher: Valaineral
        -- Stars Service
        [18] = {id = 14582, price = 15000}, -- Fourth Cuirass
        [274] = {id = 15006, price = 10500}, -- Fourth Gauntlets
        [530] = {id = 15750, price = 10500}, -- Fourth Sabatons
        [786] = {id = 16142, price = 10500}, -- Fourth Armet
        [1042] = {id = 16313, price = 10500}, -- Fourth Cuisses
        -- Emblems Service
        [34] = {id = 18494, price = 30000}, -- Fourth Toporok
        [290] = {id = 18854, price = 30000}, -- Fourth Mace
        [546] = {id = 18946, price = 30000}, -- Fourth Zaghnal
        [802] = {id = 16147, price = 60000}, -- Fourth Haube
        [1058] = {id = 15010, price = 60000}, -- Fourth Hentzes
        -- Wings Service
        [50] = {id = 15756, price = 75000}, -- Fourth Schuhs
        [306] = {id = 16316, price = 75000}, -- Fourth Schoss
        -- Medals Service
        [66] = {id = 16291, price = 45000}, -- Shield Collar
        [322] = {id = 18734, price = 45000}, -- Sturm's Report
        [578] = {id = 18735, price = 45000}, -- Sonia's Plectrum
        [834] = {id = 16292, price = 45000}, -- Bull Necklace
        [1090] = {id = 16258, price = 45000}, -- Arrestor Mantle
        [1346] = {id = 14589, price = 112500}, -- Fourth Division Brunne
        [1602] = {id = 11357, price = 15000}, -- Mythril Musketeer Livery
        -- Medal of Altana
        [82] = {id = 17685, price = 150000}, -- Lex Talionis
        [338] = {id = 11545, price = 75000} -- Fourth Mantle
    }
    local item = Bastok_AN[i]
    return item.id, item.price
end

function getWindurstNotesItem(i)
    local Windurst_AN =
    {
        [2] = {id = 15754, price = 980}, -- Sprinter's Shoes
        [258] = {id = 5428, price = 10}, -- Scroll of Instant Retrace
        [514] = {id = 14586, price = 1500}, -- Cobra Tunica
        [770] = {id = 14587, price = 1500}, -- Pilgrim Tunica
        [1026] = {id = 19150, price = 4500}, -- Cobra CLaymore
        [1282] = {id = 15841, price = 5000}, -- Recall Ring: Jugner
        [1538] = {id = 15842, price = 5000}, -- Recall Ring: Pashhow
        [1794] = {id = 15843, price = 5000}, -- Recall Ring: Meriphataud
        [2050] = {id = 10116, price = 2000}, -- Cipher: Valaineral
        -- Stars Service
        [18] = {id = 14583, price = 15000}, -- Cobra Coat
        [274] = {id = 15007, price = 10500}, -- Cobra Cuffs
        [530] = {id = 15751, price = 10500}, -- Cobra Pigaches
        [786] = {id = 16143, price = 10500}, -- Cobra Hat
        [1042] = {id = 16314, price = 10500}, -- Cobra Slops
        -- Emblems Service
        [34] = {id = 18756, price = 30000}, -- Cobra Unit Baghnakhs
        [290] = {id = 19100, price = 30000}, -- Cobra Unit Knife
        [546] = {id = 18728, price = 30000}, -- Cobra Unit Bow
        [802] = {id = 16149, price = 60000}, -- Cobra Unit Cloche
        [1058] = {id = 15011, price = 60000}, -- Cobra Unit Mittens
        -- Wings Service
        [50] = {id = 15757, price = 75000}, -- Cobra Unit Leggings
        [306] = {id = 16317, price = 75000}, -- Cobra Unit Subligar
        [580] = {id = 15758, price = 75000}, -- Cobra Unit Crackows
        [1001] = {id = 16318, price = 75000}, -- Cobra Unit Trews
        -- Medals Service
        [66] = {id = 15935, price = 45000}, -- Capricornian Rope
        [322] = {id = 15936, price = 45000}, -- Earthly Belt
        [578] = {id = 16293, price = 45000}, -- Cougar Pendant
        [834] = {id = 16294, price = 45000}, -- Crocodile Collar
        [1090] = {id = 19041, price = 45000}, -- Ariesian Grip
        [1346] = {id = 19042, price = 112500}, -- Cobra Unit Harness
        [1602] = {id = 11358, price = 15000}, -- Patriarch Protector Livery
        -- Medal of Altana
        [82] = {id = 17684, price = 150000}, -- Samudra
        [338] = {id = 11636, price = 75000} -- Mercenary Major Charm
    }
    local item = Windurst_AN[i]
    return item.id, item.price
end

-- -------------------------------------------------------------------
-- getSigilTimeStamp(player)
-- This is for the time-stamp telling player what day/time the
-- effect will last until, NOT the actual status effect duration.
-- -------------------------------------------------------------------

function getSigilTimeStamp(player)
    local timeStamp = 0 -- zero'd till math is done.

    -- TODO: calculate time stamp for menu display of when it wears off

    return timeStamp
end

-----------------------------------
-- hasMawActivated Action
-----------------------------------

-- 1st number for hasMawActivated()
-- 2nd number for player:addNationTeleport()

-- 0    1   Batallia Downs (S) (H-5)
-- 1    2   Rolanberry Fields (S) (H-6)
-- 2    4   Sauromugue Champaign (S) (K-9)
-- 3    8   Jugner Forest (S) (H-11)
-- 4    16  Pashhow Marshlands (S) (K-8)
-- 5    32  Meriphataud Mountains (S) (K-6)
-- 6    64  East Ronfaure (S) (H-5)
-- 7    128 North Gustaberg (S) (K-7)
-- 8    256 West Sarutabaruta (S) (H-9)

function hasMawActivated(player,portal)
    local mawActivated = player:getNationTeleport(MAW)
    local bit = {}

    for i = 8,0,-1 do
        twop = 2^i

        if (mawActivated >= twop) then
            bit[i]=true mawActivated = mawActivated - twop
        else
            bit[i]=false
        end
    end

    return bit[portal]
end

-- TODO:
-- Past nation teleport

-- -------------------------------------------------------------------
-- Campaign Battle Functions
-- This is for the time-stamp telling player what day/time the
-- effect will last until, NOT the actual status effect duration.
-- -------------------------------------------------------------------
xi.campaign.startCampaign = function(zone)
	local chars = zone:getPlayers()

	xi.campaign.setBattleStatus(zone, 1)

	zone:setBackgroundMusicDay(247)
	zone:setBackgroundMusicNight(247)
	zone:setSoloBattleMusic(247)
	zone:setPartyBattleMusic(247)

    for i, entity in pairs(chars) do
		entity:ChangeMusic(0, 247)
		entity:ChangeMusic(1, 247)
		entity:ChangeMusic(2, 247)
		entity:ChangeMusic(3, 247)
    end

	-- add spawning of npcs and enemies functions
end

xi.campaign.endCampaign = function(zone)
	local chars = zone:getPlayers()

	local DayMusic = zone:getLocalVar("DayMusic")
	local NightMusic = zone:getLocalVar("NightMusic")
	local SoloMusic = zone:getLocalVar("SoloMusic")
	local PartyMusic = zone:getLocalVar("PartyMusic")

	xi.campaign.setBattleStatus(zone, 0)

    zone:setBackgroundMusicDay(DayMusic)
	zone:setBackgroundMusicNight(NightMusic)
	zone:setSoloBattleMusic(SoloMusic)
	zone:setPartyBattleMusic(PartyMusic)

    for i, entity in pairs(chars) do
		entity:ChangeMusic(0, DayMusic)
		entity:ChangeMusic(1, NightMusic)
		entity:ChangeMusic(2, SoloMusic)
		entity:ChangeMusic(3, PartyMusic)

		if(entity:hasStatusEffect(xi.effect.ALLIED_TAGS)) then
			entity:delStatusEffect(xi.effect.ALLIED_TAGS)
			--perform assessment
			--reward exp and allied_notes
		end
    end

	for i=1,5 do
		xi.campaign.setUnionCount(zone, i, 0)
	end

	-- add despawning of npcs and enemies functions
end

xi.campaign.SpawnBattleEntities = function(zone, entityList, entityName)
	if(entityList ~= nil) then
		local num = math.random(1, #entityList)
		local selectedList = entityList[num]
		zone:setLocalVar(entityName, num)
		for i, id in pairs(selectedList) do
			SpawnMob(id):updateCampaignToEntireZone(1)
		end
	end
end

xi.campaign.DespawnBattleEntities = function(zone, entityList, entityName)
	if(entityList ~= nil) then
		for i, id in pairs(entityList) do
			local entity = GetMobByID(id)
			if(entity ~= nil and entity:isAlive())then
				entity:resetAI()
				if entity:isEngaged() == true then
					entity:disengage()
				end
				entity:injectActionPacket(4, 261,0,0,0)
				DespawnMob(id,1)
			end
		end
	end
	zone:setLocalVar(entityName, 0)
end

xi.campaign.EngageOpposingEntities = function(entity, opposingEntities)
	local opposingEntity = nil
	local distance = 0
	local closestDistance = 0
	local entityId = 0

	if(opposingEntities ~= nil) then

		for i, id in pairs(opposingEntities) do
			opposingEntity = GetMobByID(id)
			distance = entity:checkDistance(opposingEntity)
			if distance < 20 and entity:isEngaged() == false and entity:getStatus() ~= 2 then
				if closestDistance == 0 or distance < closestDistance then
					closestDistance = distance
					entityId = opposingEntity:getShortID()
				end
			end
		end
		if entityId ~= 0 then
			entity:engage(entityId)
		end
	end
end
