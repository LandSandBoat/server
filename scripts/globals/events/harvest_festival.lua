-----------------------------------
-- Harvest Festivals
-----------------------------------
require("scripts/globals/utils")
require("scripts/globals/npc_util")
-----------------------------------

xi = xi or {}
xi.events = xi.events or {}
xi.events.harvest = xi.events.harvest or {}

local event = SeasonalEvent:new("HarvestFestival")

xi.events.harvest.enabledCheck = function()
    local month = tonumber(os.date("%m"))
    local day = tonumber(os.date("%d"))

    return month == 10 and day >= 20 or
        month == 11 and day == 1 or
        xi.settings.main.HALLOWEEN_YEAR_ROUND == 1
end

event:setEnableCheck(xi.events.harvest.enabledCheck)

local harvestNPCs =
{
    [xi.zone.NORTHERN_SAN_DORIA] =
    {
        { name = "Vichuel",        costume = 368 }, -- Ghost
        { name = "Antonian",       costume = 365 }, -- Hound
        { name = "Attarena",       costume = 612 }, -- Orc
        { name = "Trick_Spirit",   costume = 0 },
        { name = "Trick_Specter",  costume = 0 },
        { name = "Trick_Shadow",   costume = 0 },
        { name = "Trick_Shade",    costume = 0 },
        { name = "Trick_Phantom",  costume = 0 },
        { name = "Trick_Ghost",    costume = 0 },
        { name = "Trick_Wight",    costume = 0 },
        { name = "Trick_Ghast",    costume = 0 },
        { name = "Trick_Bones",    costume = 0 },
        { name = "Trick_Skeleton", costume = 0 },
    },

    [xi.zone.SOUTHERN_SAN_DORIA] =
    {
        { name = "Machielle",  costume = 580 }, -- Yagudo
        { name = "Phamelise",  costume = 368 }, -- Ghost
        { name = "Apairemant", costume = 531 }, -- Dark Stalker
        { name = "Corua",      costume = 564 }, -- Skeleton
        { name = "Pourette",   costume = 612 }, -- Orc
    },

    [xi.zone.WINDURST_WOODS] =
    {
        { name = "Meriri",          costume = 644 }, -- Quadav
        { name = "Kuzah_Hpirohpon", costume = 580 }, -- Yagudo
        { name = "Taraihi-Perunhi", costume = 368 }, -- Ghost
        { name = "Nhobi_Zalkia",    costume = 544 }, -- Shade
        { name = "Millerovieunet",  costume = 612 }, -- Orc
    },

    [xi.zone.WINDURST_WATERS] =
    {
        { name = "Upih_Khachla",   costume = 368 }, -- Ghost
        { name = "Ness_Rugetomal", costume = 365 }, -- Hound
        { name = "Maqu_Molpih",    costume = 612 }, -- Orc
        { name = "Ahyeekih",       costume = 540 }, -- Shade
        { name = "Ensasa",         costume = 564 }, -- Skeleton
        { name = "Trick_Spirit",   costume = 0 },
        { name = "Trick_Specter",  costume = 0 },
        { name = "Trick_Shadow",   costume = 0 },
        { name = "Trick_Shade",    costume = 0 },
        { name = "Trick_Phantom",  costume = 0 },
        { name = "Trick_Ghost",    costume = 0 },
        { name = "Trick_Wight",    costume = 0 },
        { name = "Trick_Ghast",    costume = 0 },
        { name = "Trick_Bones",    costume = 0 },
        { name = "Trick_Skeleton", costume = 0 },
    },

    [xi.zone.BASTOK_MINES] =
    {
        { name = "Faustin",      costume = 365 }, -- Hound
        { name = "Mille",        costume = 644 }, -- Quadav
        { name = "Aulavia",      costume = 368 }, -- Ghost
        { name = "Proud_Beard",  costume = 544 }, -- Shade
        { name = "Emaliveulaux", costume = 564 }, -- Skeleton
    },

    [xi.zone.BASTOK_MARKETS] =
    {
        { name = "Olwyn",          costume = 368 }, -- Ghost
        { name = "Trick_Spirit",   costume = 0 },
        { name = "Trick_Specter",  costume = 0 },
        { name = "Trick_Shadow",   costume = 0 },
        { name = "Trick_Shade",    costume = 0 },
        { name = "Trick_Phantom",  costume = 0 },
        { name = "Trick_Ghost",    costume = 0 },
        { name = "Trick_Wight",    costume = 0 },
        { name = "Trick_Ghast",    costume = 0 },
        { name = "Trick_Bones",    costume = 0 },
        { name = "Trick_Skeleton", costume = 0 },
    },
}

local costumeList =
{
    { 531, 534, }, -- Stalker (Random Range)
    { 580, 607, }, -- Yagudo (Random Range)
    { 644, 671, }, -- Quadav (Random Range)
    { 535, 538, }, -- Shade (Random Range)
    { 707, 711, }, -- Gigas (Random Range)
    { 740, 756, }, -- Demon (Random Range)
    { 612, 639, }, -- Orc (Random Range)
    { 484, 511, }, -- Goblin (Random Range)
    { 368, 368, }, -- Ghost
    { 365, 365, }, -- Hound
    { 564, 564, }, -- Skeleton
}

local treatsTable2005 =
{
    xi.items.ACORN_COOKIE,
    xi.items.HANDFUL_OF_BLOODY_CHOCOLATE,
    xi.items.PIECE_OF_BUBBLE_CHOCOLATE,
    xi.items.CINNACOOKIE,
    xi.items.GINGER_COOKIE,
    xi.items.CHUNK_OF_GOBLIN_CHOCOLATE,
    xi.items.APPLE_PIE,
    xi.items.JACK_O_PIE,
    xi.items.MELON_PIE,
    xi.items.PAMAMA_TART,
    xi.items.PUMPKIN_PIE,
    xi.items.ROLANBERRY_PIE,
    xi.items.SWEET_BAKED_APPLE,
    xi.items.SERVING_OF_BAVAROIS,
    xi.items.SERVING_OF_CHERRY_BAVAROIS,
    xi.items.CHEERY_MUFFIN,
    xi.items.COFFEECAKE_MUFFIN,
    xi.items.CREAM_PUFF,
    xi.items.SERVING_OF_CRIMSON_JELLY,
    xi.items.CUPID_CHOCOLATE,
    xi.items.DRIED_BERRY,
    xi.items.DRIED_DATE,
    xi.items.SERVING_OF_ICECAP_ROLANBERRY,
    xi.items.KONIGSKUCHEN,
    xi.items.LOVE_CHOCOLATE,
    xi.items.MARRON_GLACE,
    xi.items.ORANGE_KUCHEN,
    xi.items.CONE_OF_SNOLL_GELATO,
    xi.items.SWEET_RICE_CAKE,
    xi.items.PIECE_OF_WITCH_NOUGAT,
    xi.items.SERVING_OF_BLACK_PUDDING,
    xi.items.ROLL_OF_BUCHE_AU_CHOCOLAT,
    xi.items.LEBKUCHEN_HOUSE,
    xi.items.CHOCOLATE_CAKE,
    xi.items.GATEAU_AUX_FRAISES,
    xi.items.IRMIK_HELVASI,
    xi.items.MAPLE_CAKE,
    xi.items.SERVING_OF_MILLE_FEUILLE,
    xi.items.SERVING_OF_MONT_BLANC,
    xi.items.ORANGE_CAKE,
    xi.items.PUMPKIN_CAKE,
    xi.items.BOWL_OF_SUTLAC,
    xi.items.YOGURT_CAKE,
}

local hqRewardList =
{
    [1] = { required = xi.items.PUMPKIN_HEAD,   reward = xi.items.HORROR_HEAD, },
    [2] = { required = xi.items.PUMPKIN_HEAD_2, reward = xi.items.HORROR_HEAD_2, },
    [3] = { required = xi.items.TRICK_STAFF,    reward = xi.items.TREAT_STAFF, },
    [4] = { required = xi.items.TRICK_STAFF_2,  reward = xi.items.TREAT_STAFF_2, },
    [5] = { required = xi.items.PITCHFORK,      reward = xi.items.HORROR_HEAD, },
}

local nqRewardList =
{
    xi.items.PUMPKIN_HEAD,
    xi.items.PUMPKIN_HEAD_2,
    xi.items.TRICK_STAFF,
    xi.items.TRICK_STAFF_2,
    xi.items.PITCHFORK,
}

-- To Do: Move Pitchforks acquisition into a separate method in future events
local halloweenItemsCheck = function(player)
    local headSlot = player:getEquipID(xi.slot.HEAD)
    local mainHand = player:getEquipID(xi.slot.MAIN)
    local count    = #nqRewardList

    -- Checks for HQ Upgrade
    for _, item in pairs(hqRewardList) do
        if
            (headSlot == item.required or mainHand == item.required) and
            not player:hasItem(item.reward)
        then
            return item.reward
        end
    end

    -- Checks the possible item rewards if player isn't to be rewarded an HQ item
    while count ~= 0 do
        local reward = nqRewardList[math.random(1, #nqRewardList)]

        if not player:hasItem(reward) then
            return reward
        else
            table.remove(nqRewardList, reward)
            count = count - 1
        end
    end
end

xi.events.harvest.onHalloweenTrade = function(player, npc, trade)
    local ID         = zones[player:getZoneID()]
    local itemReward = halloweenItemsCheck(player)
    local item       = trade:getItemId()
    local list      = costumeList[math.random(1, #costumeList)]
    local costume   = math.random(list[1], list[2])
    -----------------------------------
    -- 2005 edition
    -----------------------------------
    if
        xi.events.harvest.enabledCheck() and
        xi.settings.main.HALLOWEEN_2005 == 1
    then
        for itemInList = 1, #treatsTable2005 do
            if item == treatsTable2005[itemInList] then

                -- 33% chance of receiving an item
                if
                    itemReward ~= 0 and
                    npcUtil.giveItem(player, itemReward) and
                    math.random(1, 3) == 1
                then
                    player:messageSpecial(ID.text.THANK_YOU_TREAT)

                elseif player:canUseMisc(xi.zoneMisc.COSTUME) then
                    player:addStatusEffect(xi.effect.COSTUME, costume, 0, 3600)
                    player:messageSpecial(ID.text.TRICK_OR_TREAT)

                else
                    player:messageSpecial(ID.text.THANK_YOU)
                end

                player:tradeComplete()
                break
            end
        end
    end
end

-- This section is used to fix clustering issues when loading in entities upon
-- server startup. It is instead also handled on each zone intialization when a player
-- ennters the zone - otherwise NPC initializiation will be read by SQL values which
-- have each event entitity disabled by default.
xi.events.harvest.showEntities = function(zoneID)
    if xi.events.harvest.enabledCheck() then
        for _, entity in pairs(harvestNPCs[zoneID]) do
            local npc = GetZone(zoneID):queryEntitiesByName(entity.name)[1]

            if npc then
                if entity.costume > 0 then
                    npc:setModelId(entity.costume)
                else
                    npc:setStatus(xi.status.NORMAL)
                end
            end
        end
    else
        -- Only disable event NPCs
        for _, entity in pairs(harvestNPCs[zoneID]) do
            local npc = GetZone(zoneID):queryEntitiesByName(entity.name)[1]

            if
                npc and
                entity.costume == 0
            then
                npc:setStatus(xi.status.DISAPPEAR)
            end
        end
    end
end

xi.events.harvest.enableEntities = function(enabled)
end

event:setStartFunction(function()
    xi.events.harvest.enableEntities(true)
end)

event:setEndFunction(function()
    xi.events.harvest.enableEntities(false)
end)

return event
