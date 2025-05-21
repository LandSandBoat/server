-----------------------------------
-- Area: Bibiki Bay
--  NPC: Clamming Point
-----------------------------------
local ID = zones[xi.zone.BIBIKI_BAY]
-----------------------------------
---@type TNpcEntity
local entity = {}

-- TODO: Use xi.item enum for data, subtables for each row
-- clammingItems = item id, weight, drop rate, improved drop rate
local clammingItems =
{
    1311,  6, 0.001, 0.003, -- Oxblood
    885,   6, 0.002, 0.006, -- Turtle Shell
    1193,  6, 0.003, 0.009, -- HQ Crab Shell
    1446,  6, 0.004, 0.012, -- Lacquer Tree Log
    4318,  6, 0.005, 0.015, -- Bibiki Urchin
    1586,  6, 0.008, 0.024, -- Titanictus Shell
    5124, 20, 0.011, 0.033, -- Tropical Clam
    690,   6, 0.014, 0.042, -- Elm Log
    887,   6, 0.017, 0.051, -- Coral Fragment
    703,   6, 0.021, 0.063, -- Petrified Log
    691,   6, 0.025, 0.075, -- Maple Log
    4468,  6, 0.029, 0.087, -- Pamamas
    3270,  6, 0.033, 0.099, -- HQ Pugil Scales
    888,   6, 0.038, 0.114, -- Seashell
    4328,  6, 0.044, 0.132, -- Hobgoblin Bread
    485,   6, 0.051, 0.153, -- Broken Willow Rod
    510,   6, 0.058, 0.174, -- Goblin Armor
    5187,  6, 0.065, 0.195, -- Elshimo Coconut
    507,   6, 0.073, 0.219, -- Goblin Mail
    881,   6, 0.081, 0.243, -- Crab Shell
    4325,  6, 0.089, 0.267, -- Hobgoblin Pie
    936,   6, 0.098, 0.294, -- Rock Salt
    4361,  6, 0.107, 0.321, -- Nebimonite
    864,   6, 0.119, 0.357, -- Fish Scales
    4484,  6, 0.140, 0.420, -- Shall Shell
    624,   6, 0.178, 0.534, -- Pamtam Kelp
    1654, 35, 0.225, 0.675, -- Igneous Rock
    17296, 7, 0.377, 0.784, -- Pebble
    5123, 11, 0.628, 0.892, -- Jacknife
    5122,  3, 1.000, 1.000  -- Bibiki Slug
}

entity.onSpawn = function(npc)
    local firstClammingPoint = npc:getZone():queryEntitiesByName('Clamming_Point')[1]

    if firstClammingPoint then
        npc:setLocalVar('firstClammingPoint', firstClammingPoint:getID())
    else
        print('ERROR: Clamming_Point not found in queryEntitiesByName!')
    end
end

local function giveImprovedResults(player)
    if player:getMod(xi.mod.CLAMMING_IMPROVED_RESULTS) > 0 then
        return 1
    end

    return 0
end

local function giveReducedIncidents(player)
    if player:getMod(xi.mod.CLAMMING_REDUCED_INCIDENTS) > 0 then
        return 5
    end

    return 10
end

entity.onTrigger = function(player, npc)
    -- be noisy to try to get server admins to notice
    if npc:getLocalVar('firstClammingPoint') == 0 then
        print('ERROR: Clamming_Point not found!')
        return
    end

    if player:hasKeyItem(xi.ki.CLAMMING_KIT) then
        local delay = player:getLocalVar('ClammingPointDelay')

        if delay > 0 and delay > os.time() then
            player:messageSpecial(ID.text.IT_LOOKS_LIKE_SOMEONE)
        else
            local eventID = npc:getID() - npc:getLocalVar('firstClammingPoint') + 20

            player:startEvent(eventID, 0, 0, 0, 0, 0, 0, 0, 0)
        end
    else
        player:messageSpecial(ID.text.AREA_IS_LITTERED)
    end
end

-- Event update info:
-- Param 1: Stale weight of bucket in ponze, this is stale so when you have a broken bucket it does not animate when you send the update that you want to dig
-- Param 2: Max weight of bucket in ponze
-- Param 3: 0 = no Alraune, 1 = Alraune (used for the Something jumped in the bucket message with bucket size 200)
entity.onEventUpdate = function(player, csid, option, npc)
    local eventID = npc:getID() - npc:getLocalVar('firstClammingPoint') + 20

    if csid == eventID then
        if player:getCharVar('ClammingKitBroken') > 0 then -- Broken bucket
            player:messageSpecial(ID.text.YOU_CANNOT_COLLECT)
            player:updateEvent(player:getCharVar('ClammingKitWeight'), player:getCharVar('ClammingKitSize'))
            return
        end

        if
            player:getCharVar('ClammingKitSize') == 200 and
            math.random(1, 100) <= giveReducedIncidents(player)
        then
            player:setLocalVar('SomethingJumpedInBucket', 1)
            -- SE seems to add 10000 to the previous weight if Alraune had stolen your stuff.
            -- A weight higher than your capacity prevents the CS performing the clamming animation.

            -- 3rd param of 1 = Alraune CS
            player:updateEvent(player:getCharVar('ClammingKitWeight'), player:getCharVar('ClammingKitSize'), 1)

            player:incrementCharVar('ClammingKitWeight', 10000)
        else
            local dropRate = math.random() -- TODO: Adjust all values to use 0..100 scale as opposed to 0..1
            local improvedResults = giveImprovedResults(player)

            player:updateEvent(player:getCharVar('ClammingKitWeight'), player:getCharVar('ClammingKitSize'))

            for itemDrop = 3, #clammingItems, 4 do
                if dropRate <= clammingItems[itemDrop + improvedResults] then
                    player:setLocalVar('ClammedItem', clammingItems[itemDrop - 2])
                    player:incrementCharVar('ClammedItem_' .. clammingItems[itemDrop - 2], 1)
                    player:incrementCharVar('ClammingKitWeight', clammingItems[itemDrop - 1])

                    if player:getCharVar('ClammingKitWeight') > player:getCharVar('ClammingKitSize') then -- Broken bucket
                        player:setCharVar('ClammingKitBroken', 1)
                    end

                    break
                end
            end
        end
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    local eventID = npc:getID() - npc:getLocalVar('firstClammingPoint') + 20

    if csid == eventID then
        if player:getLocalVar('SomethingJumpedInBucket') > 0 then
            player:setLocalVar('SomethingJumpedInBucket', 0)

            player:messageSpecial(ID.text.SOMETHING_JUMPS_INTO)

            player:setCharVar('ClammingKitBroken', 1)

            for item = 1, #clammingItems, 4 do -- Remove items from bucket
                player:setCharVar('ClammedItem_' ..  clammingItems[item], 0)
            end
        else
            local clammedItem = player:getLocalVar('ClammedItem')

            if clammedItem > 0 then
                if player:getCharVar('ClammingKitBroken') > 0 then --Broken bucket
                    player:messageSpecial(ID.text.THE_WEIGHT_IS_TOO_MUCH, clammedItem)

                    for item = 1, #clammingItems, 4 do -- Remove items from bucket
                        player:setCharVar('ClammedItem_' ..  clammingItems[item], 0)
                    end
                else
                    player:messageSpecial(ID.text.YOU_FIND_ITEM, clammedItem)
                end

                player:setLocalVar('ClammingPointDelay', os.time() + 10)
                player:setLocalVar('ClammedItem', 0)
            end
        end
    end
end

return entity
