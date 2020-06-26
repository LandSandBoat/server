-----------------------------------
-- Full Speed Ahead! Helper
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs/IDs")
require("scripts/globals/status")
require("scripts/globals/utils")
require("scripts/globals/zone")
-----------------------------------

--[[
Debugging:
Reset: !delquest 3 179

CharVar: [QUEST]FullSpeedAhead == ...
1 : Starting minigame on Normal Mode
2 : Starting minigame on Easy Mode
3 : Minigame active/playable
4 : Minigame complete, time to hand in

FULL_SPEED_AHEAD effect power:
0 : Normal Mode
1 : Easy Mode
]]--

tpz = tpz or {}
tpz.full_speed_ahead = tpz.full_speed_ahead or {}

tpz.full_speed_ahead.duration = 600
tpz.full_speed_ahead.motivation_decay = 2
tpz.full_speed_ahead.motivation_food_bonus = 15
tpz.full_speed_ahead.pep_growth = 1

tpz.full_speed_ahead.onEffectGain = function(player, effect)
    player:setLocalVar("FSA_Time", os.time() + tpz.full_speed_ahead.duration)
    player:setLocalVar("FSA_Motivation", 100)
    player:setLocalVar("FSA_Pep", 0)
    player:setLocalVar("FSA_Food", 0xFF)
    player:setLocalVar("FSA_FoodCount", 0)
    player:addStatusEffect(tpz.effect.MOUNTED, tpz.mount.QUEST_RAPTOR, 3, 0)
    player:setCharVar("[QUEST]FullSpeedAhead", 3)
end

tpz.full_speed_ahead.onEffectLose = function(player, effect)
    player:delStatusEffectSilent(tpz.effect.MOUNTED)
    player:countdown(0) 
    player:enableEntities({})

    -- If in Batallia Downs and didn't get the completion flag (failed/dismounted)
    if player:getZoneID() == tpz.zone.BATALLIA_DOWNS and player:getCharVar("[QUEST]FullSpeedAhead") ~= 4 then
        player:startEvent(26, 0, effect:getPower())
    end
end

tpz.full_speed_ahead.tick = function(player, effect)
    player:setLocalVar("FSA_Motivation", player:getLocalVar("FSA_Motivation") - tpz.full_speed_ahead.motivation_decay + effect:getPower())
    player:setLocalVar("FSA_Pep", player:getLocalVar("FSA_Pep") + tpz.full_speed_ahead.pep_growth + effect:getPower())

    local timeLeft = player:getLocalVar("FSA_Time") - os.time()
    local motivation = player:getLocalVar("FSA_Motivation")
    local pep = player:getLocalVar("FSA_Pep")
    local food_byte = player:getLocalVar("FSA_Food")
    local food_count = player:getLocalVar("FSA_FoodCount")

    local food_data = {}
    for i = 0, 7 do
        if bit.band(food_byte, bit.lshift(1, i)) > 0 then
            table.insert(food_data, ID.npc.BLUE_BEAM_BASE + i)
            table.insert(food_data, ID.npc.RAPTOR_FOOD_BASE + i)
        end
    end

    if motivation <= 0 or timeLeft <= 0 or not player:hasStatusEffect(tpz.effect.MOUNTED) then
        player:delStatusEffectSilent(tpz.effect.FULL_SPEED_AHEAD)
    else
        player:countdown(timeLeft, "Motivation", motivation, "Pep", pep)
        player:enableEntities(food_data)
    end
end

tpz.full_speed_ahead.onRegionEnter = function(player, index)
    local food_byte = player:getLocalVar("FSA_Food")
    local food_count = player:getLocalVar("FSA_FoodCount")
    local motivation = player:getLocalVar("FSA_Motivation")

    if index == 9 and food_count >= 5 then -- Syrillia
        player:startEvent(24) -- End CS and teleport
    elseif bit.band(food_byte, bit.lshift(1, index - 1)) > 0 then
        local new_food_byte = food_byte - bit.lshift(1, index - 1)
        player:setLocalVar("FSA_Food", new_food_byte)
        player:setLocalVar("FSA_FoodCount", food_count + 1)

        local new_food_count = player:getLocalVar("FSA_FoodCount")
        local new_motivation = utils.clamp(motivation + tpz.full_speed_ahead.motivation_food_bonus, 0, 100)
        player:setLocalVar("FSA_Motivation", new_motivation)
        
        -- Hearts
        player:independantAnimation(player, 251, 4)

        player:messageSpecial(ID.text.RAPTOR_OVERCOME_MUNCHIES, new_food_count, 5)

        if new_food_count == 5 then
            player:messageSpecial(ID.text.MEET_SYRILLIA)
        end
    end
end

tpz.full_speed_ahead.onCheer = function(player)
    local timeLeft = player:getLocalVar("FSA_Time") - os.time()
    local motivation = player:getLocalVar("FSA_Motivation")
    local pep = player:getLocalVar("FSA_Pep")

    local new_motivation = utils.clamp(motivation + (pep / 2), 0, 100)

    player:setLocalVar("FSA_Motivation", new_motivation)
    player:setLocalVar("FSA_Pep", 0)

    player:messageSpecial(ID.text.RAPTOR_SECOND_WIND)

    -- Music Notes
    player:independantAnimation(player, 252, 4)

    player:countdown(timeLeft, "Motivation", new_motivation, "Pep", 0)
end

tpz.full_speed_ahead.completeGame = function(player)
    player:setCharVar("[QUEST]FullSpeedAhead", 4)
    player:delStatusEffectSilent(tpz.effect.FULL_SPEED_AHEAD)
    player:setPos(-104.5, 0, 187.4, 64, 244)
end

tpz.fsa = tpz.full_speed_ahead
