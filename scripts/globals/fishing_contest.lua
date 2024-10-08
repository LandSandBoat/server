-----------------------------------
-- Fish Ranking Contest Functions
-----------------------------------
require('scripts/globals/utils')
-----------------------------------
xi = xi or {}
xi.fishingContest = xi.fishingContest or {}

local exDataIndex =
{
    LENGTH = 0x00,
    WEIGHT = 0x02,
    RANKED = 0x04,
}

xi.fishingContest.fish =
{
    -- NOTE: If you don't want certain fish included in the contest (era restrictions, or whatever),
    --   then you must comment out the lines containing unwanted fish.  The C++ core calls the
    --   random function in this file to select a fish for each contest, which uses this table.

    { id = xi.item.GRIMMONITE,      name = 'grimmonite'      , realName = 'Grimmonite'      },
    { id = xi.item.RYUGU_TITAN,     name = 'ryugu_titan'     , realName = 'Ryugu Titan'     },
    { id = xi.item.GIANT_DONKO,     name = 'giant_donko'     , realName = 'Giant Donko'     },
    { id = xi.item.JUNGLE_CATFISH,  name = 'jungle_catfish'  , realName = 'Jungle Catfish'  },
    { id = xi.item.GIANT_CHIRAI,    name = 'giant_chirai'    , realName = 'Giant Chirai'    },
    { id = xi.item.CAVE_CHERAX,     name = 'cave_cherax'     , realName = 'Cave Cherax'     },
    { id = xi.item.ARMORED_PISCES,  name = 'armored_pisces'  , realName = 'Armored Pisces'  },
    { id = xi.item.TRICORN,         name = 'tricorn'         , realName = 'Tricorn'         },
    { id = xi.item.EMPEROR_FISH,    name = 'emperor_fish'    , realName = 'Emperor Fish'    },
    { id = xi.item.MONKE_ONKE,      name = 'monke-onke'      , realName = 'Monke-Onke'      },
    { id = xi.item.TAKITARO,        name = 'takitaro'        , realName = 'Takitaro'        },
    { id = xi.item.GIANT_CATFISH,   name = 'giant_catfish'   , realName = 'Giant Catfish'   },
    { id = xi.item.BLADEFISH,       name = 'bladefish'       , realName = 'Bladefish'       },
    { id = xi.item.GIGANT_SQUID,    name = 'gigant_squid'    , realName = 'Gigant Squid'    },
    { id = xi.item.SEA_ZOMBIE,      name = 'sea_zombie'      , realName = 'Sea Zombie'      },
    { id = xi.item.TITANICTUS,      name = 'titanictus'      , realName = 'Titanictus'      },
    { id = xi.item.GAVIAL_FISH,     name = 'gavial_fish'     , realName = 'Gavial Fish'     },
    { id = xi.item.THREE_EYED_FISH, name = 'three-eyed_fish' , realName = 'Three-eyed Fish' },
    { id = xi.item.BHEFHEL_MARLIN,  name = 'bhefhel_marlin'  , realName = 'Bhefhel Marlin'  },
    { id = xi.item.GUGRU_TUNA,      name = 'gugru_tuna'      , realName = 'Gugru Tuna'      },
    { id = xi.item.TITANIC_SAWFISH, name = 'titanic_sawfish' , realName = 'Titanic Sawfish' },
    { id = xi.item.GUGRUSAURUS,     name = 'gugrusaurus'     , realName = 'Gugrusaurus'     },
    { id = xi.item.LIK,             name = 'lik'             , realName = 'Lik'             },
}

xi.fishingContest.criteria =
{
    SIZE   = 0,
    WEIGHT = 1,
    BOTH   = 2,
}

xi.fishingContest.measure =
{
    GREATEST = 0,
    SMALLEST = 1,
}

xi.fishingContest.status =
{
    CONTESTING = 0, -- Usually used for building manual contest, but a simple 5 minute buffer
    OPENING    = 1, -- 30 mins, warning to players that contest is opening soon
    ACCEPTING  = 2, -- 2 week window during which trades are accepted
    RELEASING  = 3, -- Submissions closed, preparing to release the results
    PRESENTING = 4, -- Results posted, contestants may claim their prizes
    HIATUS     = 5, -- Approx 35 minute window after presentations
    CLOSED     = 6, -- Only used when contest is closed and inactive.  No automatic progression from this stage
}

xi.fishingContest.reward =
{
    -- Defines the reward at each rank
    [ 1] = { gil = 50000, item = xi.item.PELICAN_RING, title = xi.title.GOLD_HOOK    },
    [ 2] = { gil = 25000, item = xi.item.PELICAN_RING, title = xi.title.MYTHRIL_HOOK },
    [ 3] = { gil = 10000, item = xi.item.PELICAN_RING, title = xi.title.SILVER_HOOK  },
    [ 4] = { gil = 1000,  item = xi.item.PELICAN_RING, title = xi.title.COPPER_HOOK  },
    [ 5] = { gil = 1000,  item = xi.item.PELICAN_RING, title = xi.title.COPPER_HOOK  },
    [ 6] = { gil = 1000,  item = xi.item.PELICAN_RING, title = xi.title.COPPER_HOOK  },
    [ 7] = { gil = 1000,  item = xi.item.PELICAN_RING, title = xi.title.COPPER_HOOK  },
    [ 8] = { gil = 1000,  item = xi.item.PELICAN_RING, title = xi.title.COPPER_HOOK  },
    [ 9] = { gil = 1000,  item = xi.item.PELICAN_RING, title = xi.title.COPPER_HOOK  },
    [10] = { gil = 1000,  item = xi.item.PELICAN_RING, title = xi.title.COPPER_HOOK  },
    [11] = {              item = xi.item.PELICAN_RING,                               },
    [12] = {              item = xi.item.PELICAN_RING,                               },
    [13] = {              item = xi.item.PELICAN_RING,                               },
    [14] = {              item = xi.item.PELICAN_RING,                               },
    [15] = {              item = xi.item.PELICAN_RING,                               },
    [16] = {              item = xi.item.PELICAN_RING,                               },
    [17] = {              item = xi.item.PELICAN_RING,                               },
    [18] = {              item = xi.item.PELICAN_RING,                               },
    [19] = {              item = xi.item.PELICAN_RING,                               },
    [20] = {              item = xi.item.PELICAN_RING,                               },
}

xi.fishingContest.interval =
{
    -- These intervals indicate how long each phase lasts before being automatically progressed.
    -- Total cycle is 28 days, 35 minutes based on captures.  May be varied if contest is manually controlled
    [xi.fishingContest.status.CONTESTING] = 300,        -- 00 days 00 hours 05 mins
    [xi.fishingContest.status.OPENING]    = 1500,       -- 00 days 00 hours 25 mins
    [xi.fishingContest.status.ACCEPTING]  = 1209600,    -- 14 days 00 hours 00 mins
    [xi.fishingContest.status.RELEASING]  = 1800,       -- 00 days 00 hours 30 mins
    [xi.fishingContest.status.PRESENTING] = 1206000,    -- 13 days 23 hours 00 minutes
    [xi.fishingContest.status.HIATUS]     = 2100,       -- 00 days 00 hours 35 minutes
    [xi.fishingContest.status.CLOSED]     = 0xFFFFFFFF, -- Must be manually controlled
}

-----------------------------------
-- LOCAL FUNCTIONS
-----------------------------------

-- Determine the slot that contains the fish being traded
local function findFishSlot(trade, fish)
    for i = 0, trade:getSlotCount() - 1 do
        if trade:getItemId(i) == fish then
            return i
        end
    end

    return 0
end

-- The npcUtil.giveItem function currently does not support custom exdata
-- Since we need to include the measurements of the fish, we need a modified function
local function giveFish(player, params)
    params = params or {}
    local ID = zones[player:getZoneID()]
    local fishid = params.id

    -- does player have enough inventory space?
    if player:getFreeSlotsCount() < 1 then
        local messageId = ID.text.ITEM_CANNOT_BE_OBTAINED + 4
        player:messageSpecial(messageId, fishid)
        return false
    end

    -- give items to player
    if player:addItem(params) then
        player:messageSpecial(ID.text.ITEM_OBTAINED, fishid)
    else
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, fishid)
        return false
    end

    return true
end

local function getAwardInteger(awardTable)
    return bit.lshift(awardTable['rank4to10'], 24) + bit.lshift(awardTable['rank3'], 16) + bit.lshift(awardTable['rank2'], 8) + awardTable['rank1']
end

-- Determine if the player has a reward pending in the current contest
-- This will not permit rewarding for ongoing contests until it is ACTUALLY at the presenting stage.
local function isRewardAvailable(player)
    local awards = player:getContestRewardStatus()

    if awards ~= nil then
        if
            awards['rank'] > 0 and
            awards['rank'] <= 20
        then
            return 1
        end
    end

    return 0
end

-- This returns the data necessary to send the packet with the 'time remaining until stage change' data to the player
local function getTimeRemaining(changeTime)
    local timeTable = {}
    local currentTime = os.time()
    if changeTime > currentTime then
        local timeDelta = changeTime - currentTime
        timeTable =
        {
            ['days']    = math.floor(timeDelta / (60 * 60 * 24)),
            ['hours']   = math.floor((timeDelta / (60 * 60)) % 24),
            ['minutes'] = math.floor((timeDelta / 60) % 60),
        }
    else
        timeTable =
        {
            ['days']    = 0,
            ['hours']   = 0,
            ['minutes'] = 0,
        }
    end

    return timeTable
end

-- Provides the score of the submission
local function scoreFish(length, weight, criteria)
    local score = 0
    if criteria == xi.fishingContest.criteria.SIZE then
        score = length
    elseif criteria == xi.fishingContest.criteria.WEIGHT then
        score = weight
    else
        score = length + weight
    end

    return score
end

-- Determines the rewards to be granted based on rank and share
local function getPlayerReward(player)
    local status = player:getContestRewardStatus()

    if status ~= nil then
        local rank  = status['rank']
        local share = status['share'] or 1
        if
            rank > 0 and
            rank <= 20
        then
            local reward = xi.fishingContest.reward[rank]
            if reward.gil then
                reward.gil = reward.gil / share
            end

            return reward
        end
    end

    return nil
end

-----------------------------------
-- GLOBAL FUNCTIONS
-----------------------------------

-- Create the table of exdata
xi.fishingContest.createExData = function(length, weight, ranked)
    -- If the provided data table has a nil value, the key will not be passed to the setExData function
    -- setExData only accepts one-byte keys and vals so we need to break down the 16-bit vars
    local exData = {}
    if length ~= nil then
        exData[exDataIndex.LENGTH    ] = bit.band(length, 0x00FF)
        exData[exDataIndex.LENGTH + 1] = bit.rshift(bit.band(length, 0xFF00), 8)
    end

    if weight ~= nil then
        exData[exDataIndex.WEIGHT    ] = bit.band(weight, 0x00FF)
        exData[exDataIndex.WEIGHT + 1] = bit.rshift(bit.band(weight, 0xFF00), 8)
    end

    if ranked ~= nil then
        exData[exDataIndex.RANKED    ] = ranked
    end

    return exData
end

-- Read the necessary data from the exdata
xi.fishingContest.getFishData = function(fishItem)
    local fishData = fishItem:getExData()
    local fishTable = {}

    fishTable['length'] = (bit.lshift(fishData[exDataIndex.LENGTH + 1], 8) + fishData[exDataIndex.LENGTH]) or 0
    fishTable['weight'] = (bit.lshift(fishData[exDataIndex.WEIGHT + 1], 8) + fishData[exDataIndex.WEIGHT]) or 0
    fishTable['ranked'] = fishData[exDataIndex.RANKED]

    return fishTable
end

-- Update the fish exdata
xi.fishingContest.setFishData = function(fishItem, length, weight, ranked)
    -- Data Table should have only three possible options: 'length', 'width', and 'ranked'
    if fishItem == nil then
        return
    end

    -- If the provided data table has a nil value, the key will not be passed to the setExData function
    -- setExData only accepts one-byte keys and vals so we need to break down the 16-bit vars
    local newExData = xi.fishingContest.createExData(length, weight, ranked)

    if newExData ~= nil then
        fishItem:setExData(newExData)
    end
end

xi.fishingContest.selectContestFish = function()
    return utils.randomEntry(xi.fishingContest.fish)['id']
end

xi.fishingContest.getStageChangeTime = function(stage, stageStartTime)
    -- If the value is invalid, send back the 'never change' time
    if
        stage >= xi.fishingContest.status.CONTESTING and
        stage < xi.fishingContest.status.CLOSED
    then
        return stageStartTime + xi.fishingContest.interval[stage]
    end

    return xi.fishingContest.interval[xi.fishingContest.status.CLOSED]
end

xi.fishingContest.onStageProgress = function(newStage)
    -- TODO: Capture NPC text on stage progressions
end

xi.fishingContest.onTrigger = function(player, npc)
    local contest = GetFishingContest()
    if contest == nil then
        return
    end

    player:startEvent(10006, {
        [0] = contest['status'] or xi.fishingContest.status.CLOSED,
        [1] = contest['fishid'] or 0,   -- Fish ID for the contest
        [2] = contest['criteria'] or 0, -- 0 = Size, 1 = Weight, 2 = Size + Weight
        [3] = contest['measure'] or 0,  -- 0 = greatest, 1 = smallest
    })
end

xi.fishingContest.onTrade = function(player, npc, trade)
    -- Handle fish submission
    local contest = GetFishingContest()
    if contest == nil then
        return
    end

    -- Check to see if the traded fish is the right one
    if
        contest['status'] == xi.fishingContest.status.ACCEPTING and
        npcUtil.tradeHasExactly(trade, contest['fishid'])
    then
        local fishItem = trade:getItem(findFishSlot(trade, contest['fishid']))
        local fishData = xi.fishingContest.getFishData(fishItem)

        if fishData == nil then
            return
        elseif
            fishData['ranked'] == 1 or
            fishData['length'] == 0 or
            fishData['weight'] == 0
        then
            -- Fish has already been ranked previously
            player:startEvent(10007, { [4] = 1 })
        else
            -- Fish is a valid entry, not previously ranked
            -- Player local vars used to hold submission data until end of event
            player:setLocalVar('[FishContest]Length', fishData['length'])
            player:setLocalVar('[FishContest]Weight', fishData['weight'])

            player:startEvent(10007, {
                [5] = scoreFish(fishData['length'], fishData['weight'], contest['criteria']),
                [6] = player:getContestScore(),
            })
        end
    end
end

xi.fishingContest.onEventUpdate = function(player, csid, option, npc)
    local contest = GetFishingContest()
    if contest == nil then
        return
    end

    if csid == 10006 then
        if option == 147 then
        -- Award History
            player:updateEvent({ [5] = getAwardInteger(player:getContestRankHistory()) })

        elseif option == 148 then
            -- Pushed by client after informing of ranking status?  Leaving open for now

        elseif option == 149 then
        -- View Current Rules | Ranking Results | Receive Award
            if contest['status'] == xi.fishingContest.status.ACCEPTING then
                player:updateEvent({
                    [0] = contest['status'],
                    [1] = contest['fishid'],
                    [2] = contest['criteria'],
                    [3] = contest['measure'],
                })
            elseif contest['status'] == xi.fishingContest.status.PRESENTING then
                player:updateEvent({
                    [0] = contest['status'],
                    [1] = contest['fishid'],
                    [2] = contest['criteria'],
                    [3] = contest['measure'],
                    [4] = isRewardAvailable(player),
                })
            end
        elseif option == 150 then
        -- Initial option
            local time = getTimeRemaining(contest['changetime'])
            if contest['status'] == xi.fishingContest.status.ACCEPTING then
                player:updateEvent({
                    [0] = contest['status'],
                    [1] = contest['fishid'],
                    [2] = contest['criteria'],
                    [3] = contest['measure'],
                    [4] = isRewardAvailable(player),
                    [5] = time['days'],
                    [6] = time['hours'],
                    [7] = time['minutes'],
                })
            elseif contest['status'] == xi.fishingContest.status.PRESENTING then
                player:updateEvent({
                    [0] = contest['status'],
                    [1] = contest['fishid'],
                    [2] = contest['criteria'],
                    [3] = contest['measure'],
                    [4] = isRewardAvailable(player),
                    [5] = time['days'],
                    [6] = time['hours'],
                    [7] = time['minutes'],
                })
            end
        elseif option == 151 then
        -- Confirm request to confirm entry
            player:updateEvent({
                [0] = contest['status'],
                [1] = contest['fishid'],
                [2] = contest['criteria'],
                [3] = contest['measure'],
                [5] = player:getContestScore(),
            })
        elseif option == 152 then
        -- Confirm request to withdraw entry
            player:withdrawContestFish()
        end

    elseif csid == 10007 then
        if option == 144 then
            if player:getGil() < 500 then
                -- Player does not have enough gil
                player:messageSpecial(zones[player:getZoneID()].text.INSUFFICIENT_GIL)
                return
            else
                player:updateEvent()
            end
        elseif option == 145 then
            player:updateEvent()
        end
    end
end

xi.fishingContest.onEventFinish = function(player, csid, option, npc)
    local contest = GetFishingContest()
    if contest == nil then
        return
    end

    if csid == 10007 then
        -- Give the player back a fish with the same stats, but tagged for Ranking
        if option == 145 then
            local length = player:getLocalVar('[FishContest]Length')
            local weight = player:getLocalVar('[FishContest]Weight')
            local obtained = giveFish(player, { id = contest['fishid'],
                                                quantity = 1,
                                                exdata = xi.fishingContest.createExData(length, weight, 1) })
            if obtained then
                player:confirmTrade()
                player:delGil(500) -- Pay the registration fee of 500 gil.
                player:submitContestFish(scoreFish(length, weight, contest['criteria']))
                player:setLocalVar('[FishContest]Length', 0)
                player:setLocalVar('[FishContest]Weight', 0)
            end
        end

    elseif csid == 10006 then
        if
            option == 149 and
            isRewardAvailable(player) > 0 and
            contest['status'] == xi.fishingContest.status.PRESENTING
        then
            -- Issue the player a reward and flag it as awarded.
            local reward = getPlayerReward(player)
            if
                reward ~= nil and
                npcUtil.giveReward(player, reward)
            then
                player:claimContestReward()
            end
        end
    end
end
