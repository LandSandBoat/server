-----------------------------------
-- Full Speed Ahead! Helper
-----------------------------------
require('scripts/globals/status')
require('scripts/globals/utils')
require('scripts/globals/zone')
-----------------------------------
local batalliaID = require('scripts/zones/Batallia_Downs/IDs')
-----------------------------------

--[[
Debugging:
Start: !setplayervar <name> [QUEST]FullSpeedAhead 1
       !zone { Batallia Downs }

Reset Quest: !delquest 3 179

CharVar: [QUEST]FullSpeedAhead == ...
1 : Starting minigame on Normal Mode
2 : Starting minigame on Easy Mode
3 : Minigame active/playable
4 : Minigame complete, time to hand in

FULL_SPEED_AHEAD effect power:
0 : Normal Mode
1 : Easy Mode
]]--

xi = xi or {}
xi.full_speed_ahead = xi.full_speed_ahead or {}

xi.full_speed_ahead.duration              = 600
xi.full_speed_ahead.motivation_decay      = 2
xi.full_speed_ahead.motivation_food_bonus = 15
xi.full_speed_ahead.pep_growth            = 1

xi.full_speed_ahead.onEffectGain = function(player, effect)
    player:setLocalVar("FSA_Time", os.time() + xi.full_speed_ahead.duration)
    player:setLocalVar("FSA_Motivation", 100)
    player:setLocalVar("FSA_Pep", 0)
    player:setLocalVar("FSA_Food", 0xFF)
    player:setLocalVar("FSA_FoodCount", 0)
    -- NOTE: This used to be mount id 1: QUEST_RAPTOR, but it appears to have changed
    player:addStatusEffect(xi.effect.MOUNTED, xi.mount.RAPTOR, 3, 0)
    player:setCharVar("[QUEST]FullSpeedAhead", 3)
end

xi.full_speed_ahead.onEffectLose = function(player, effect)
    player:delStatusEffectSilent(xi.effect.MOUNTED)
    player:countdown(0)
    player:enableEntities({})

    -- If in Batallia Downs and didn't get the completion flag (failed/dismounted)
    if
        player:getZoneID() == xi.zone.BATALLIA_DOWNS and
        player:getCharVar("[QUEST]FullSpeedAhead") ~= 4
    then
        player:startEvent(26, 0, effect:getPower())
    end
end

xi.full_speed_ahead.tick = function(player, effect)
    -- TODO: slow mount speed under 50% motivation
    -- TODO: motivation drains faster when climbing steep hills, red exclamation mark and sweat animation
    player:setLocalVar("FSA_Motivation", player:getLocalVar("FSA_Motivation") - xi.full_speed_ahead.motivation_decay + effect:getPower())
    player:setLocalVar("FSA_Pep", player:getLocalVar("FSA_Pep") + xi.full_speed_ahead.pep_growth + effect:getPower())

    local timeLeft   = player:getLocalVar("FSA_Time") - os.time()
    local motivation = player:getLocalVar("FSA_Motivation")
    local pep        = player:getLocalVar("FSA_Pep")
    local foodByte   = player:getLocalVar("FSA_Food")
    -- local food_count = player:getLocalVar("FSA_FoodCount")

    local foodData = {}
    for i = 0, 7 do
        if bit.band(foodByte, bit.lshift(1, i)) > 0 then
            table.insert(foodData, batalliaID.npc.BLUE_BEAM_BASE + i)
            table.insert(foodData, batalliaID.npc.RAPTOR_FOOD_BASE + i)
        end
    end

    if
        motivation <= 0 or
        timeLeft <= 0 or
        not player:hasStatusEffect(xi.effect.MOUNTED)
    then
        player:delStatusEffectSilent(xi.effect.FULL_SPEED_AHEAD)
    else
        player:countdown(timeLeft, "Motivation", motivation, "Pep", pep)
        player:enableEntities(foodData)
    end
end

xi.full_speed_ahead.onTriggerAreaEnter = function(player, index)
    local foodByte   = player:getLocalVar("FSA_Food")
    local foodCount  = player:getLocalVar("FSA_FoodCount")
    local motivation = player:getLocalVar("FSA_Motivation")

    if index == 9 and foodCount >= 5 then -- Syrillia
        player:startEvent(24) -- End CS and teleport
    elseif bit.band(foodByte, bit.lshift(1, index - 1)) > 0 then
        local newFoodByte = foodByte - bit.lshift(1, index - 1)
        player:setLocalVar("FSA_Food", newFoodByte)
        player:setLocalVar("FSA_FoodCount", foodCount + 1)

        local newFoodCount  = player:getLocalVar("FSA_FoodCount")
        local newMotivation = utils.clamp(motivation + xi.full_speed_ahead.motivation_food_bonus, 0, 100)
        player:setLocalVar("FSA_Motivation", newMotivation)

        -- Hearts
        player:independentAnimation(player, 251, 4)

        player:messageSpecial(batalliaID.text.RAPTOR_OVERCOME_MUNCHIES, newFoodCount, 5)

        if newFoodCount == 5 then
            player:messageSpecial(batalliaID.text.MEET_SYRILLIA)
        end
    end
end

xi.full_speed_ahead.onCheer = function(player)
    local timeLeft   = player:getLocalVar("FSA_Time") - os.time()
    local motivation = player:getLocalVar("FSA_Motivation")
    local pep        = player:getLocalVar("FSA_Pep")

    local newMotivation = utils.clamp(motivation + (pep / 2), 0, 100)

    player:setLocalVar("FSA_Motivation", newMotivation)
    player:setLocalVar("FSA_Pep", 0)

    player:messageSpecial(batalliaID.text.RAPTOR_SECOND_WIND)

    -- Music Notes
    player:independentAnimation(player, 252, 4)

    player:countdown(timeLeft, "Motivation", newMotivation, "Pep", 0)
end

xi.full_speed_ahead.completeGame = function(player)
    player:setCharVar("[QUEST]FullSpeedAhead", 4)
    player:delStatusEffectSilent(xi.effect.FULL_SPEED_AHEAD)
    player:setPos(-104.5, 0, 187.4, 64, 244)
end

xi.fsa = xi.full_speed_ahead

return xi.full_speed_ahead -- NOTE: This return does nothing apart from silence the hot-reloader
