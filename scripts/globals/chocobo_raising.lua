-----------------------------------
-- Chocobo Raising
-- Dedicated to 'Friend' the Chocobo. RIP.
--
-- http://www.playonline.com/pcd/update/ff11us/20060822VOL2B1/detail.html
-- https://ffxiclopedia.fandom.com/wiki/Category:Chocobo_Raising
-- https://www.bg-wiki.com/ffxi/Category:Chocobo_Raising
-- https://ffxiclopedia.fandom.com/wiki/Arael%27s_Chocobo_Raising_Guide
-- https://ffxi.gamerescape.com/wiki/Arael%27s_Chocobo_Raising_Guide
-- https://www.ffxionline.com/forum/ffxi-game-related/crafting-synthesis/chocobo-raising-racing-and-digging/63439-chocobo-color-to-egg-stats-fact
-- https://www.ffxiah.com/forum/topic/32770/ninians-guide-to-chocobo-raising-v2/
-- https://docs.google.com/spreadsheets/d/1LluCnhI_LTvxW-Q6X6R2i-_jL9TABEbKcGPBMZOOlYU/edit#gid=0
-- https://ffxiclopedia.fandom.com/wiki/Carnivors_Guide_to_Chocobo_Breeding
-- https://ffxiclopedia.fandom.com/wiki/Chocobo_Raising/Go_on_a_Walk
--
-- VCS Chocobo Trainers
-- San d’Oria: Hantileon : !pos -2.675 -0.100 -105.287 230
-- Bastok: Zopago        : !pos 51.706 -0.126 -109.065 234
-- Windurst: Pulonono    : !pos 130.124 -6.35 -119.341 241
--
-- Eggs
-- NOTE: Purchased eggs and eggs from ISNM have nothing in their exdata!
-- Purchased/quested:
-- CHOCOBO_EGG_FAINTLY_WARM  : !additem 2312
-- CHOCOBO_EGG_SLIGHTLY_WARM : !additem 2314
-- CHOCOBO_EGG_A_BIT_WARM    : !additem 2317
-- ISNM:
-- CHOCOBO_EGG_A_LITTLE_WARM : !additem 2318
-- CHOCOBO_EGG_SOMEWHAT_WARM : !additem 2319
-----------------------------------
require('scripts/globals/chocobo_names')
require('scripts/globals/hobbies/chocobo_raising/choco_data')
require('scripts/globals/hobbies/chocobo_raising/condense_events')
require('scripts/globals/hobbies/chocobo_raising/constants')
require('scripts/globals/hobbies/chocobo_raising/event_playout')
require('scripts/globals/hobbies/chocobo_raising/event_vm')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}
xi.chocoboRaising.chocoState = xi.chocoboRaising.chocoState or {}

local debug = utils.getDebugPlayerPrinter(xi.settings.main.DEBUG_CHOCOBO_RAISING)

-----------------------------------
-- Settings
-----------------------------------

-- Length of a day, in seconds (default is 1x day Earth time, in seconds)
-- Other reasonable settings:
-- One Earth day: 86400 seconds (default)
-- One Vana'diel week: 27648 seconds - 7 hours, 40 minutes, 48 seconds Earth time
-- One Vana'diel day: 3456 seconds - 57 minutes, 36 seconds Earth time (1/25 of one Earth day)
xi.chocoboRaising.dayLength        = 86400
xi.chocoboRaising.daysToChick      = 4
xi.chocoboRaising.daysToAdolescent = 19
xi.chocoboRaising.daysToAdult1     = 29
xi.chocoboRaising.daysToAdult2     = 43 -- 'You've done a great job raising this chocobo. Now is the best time to improve its attributes.'
xi.chocoboRaising.daysToAdult3     = 64 -- 'Chocobo's growth seems to have stabilized. The animal has developed quite a distinguished air.'
xi.chocoboRaising.daysToAdult4     = 129 -- Retirement

-- TODO: Make sure all settings are plainly described.
-- TODO: Add settings to disable retirement, with/without infinite stat growth.
-- xi.settings.main.CHOCOBO_RAISING_DISABLE_RETIREMENT  = false, -- true/false.
-- xi.settings.main.CHOCOBO_RAISING_STAT_GROWTH_CAP     = 512,   -- int.

-- Maximum randomness applied to walkEnergyAmount for a given walk
xi.chocoboRaising.walkEnergyRandomness = 5

-- The amount of energy taken by: short, medium and long walks (+ a random amount between 0 and walkEnergyRandomness)
xi.chocoboRaising.walkEnergyAmount = { 25, 33, 50 }

-- Chance for an event to happen while on a walk (checked as chance < math.random(1, 100))
xi.chocoboRaising.walkEventChance = 33

-- The amount of energy taken by: watch over chocobo
xi.chocoboRaising.watchOverEnergy = 5

-- https://www.bg-wiki.com/ffxi/Category:Chocobo_Raising
-- Rental chocobos are bred for speed and endurance, so they are automatically at the capped mount speed (+100% of base movement speed) and riding time.
-- Personal chocobos will need the highest Speed rating and the ability Gallop in order to move at the same speed.
-- F is the base grade (0 ranks), up through A to S to SS (+7 ranks)
-- Max ranks is +9: with skills and relevant silks.

-- Chocobo Speed Ratings
xi.chocoboRaising.ridingSpeedBase    =  80
xi.chocoboRaising.ridingSpeedPerRank = 2.5
xi.chocoboRaising.ridingSpeedCap     = 100
-- Ability: Gallop adds 1 rank
-- Purple Race Silks add 1 rank
-- Leads to absolute max of: 80 + (2.5 * 9): 102.5 -> clamped to 100

-- Chocobo Endurance Ratings (minutes)
xi.chocoboRaising.ridingTimeBase    = 17
xi.chocoboRaising.ridingTimePerRank =  4
xi.chocoboRaising.ridingTimeCap     = 45
-- Ability: Canter adds 1 rank
-- Red Race Silks add 1 rank
-- Leads to absolute max of: 17 + (4 * 9): 53 -> clamped to 45

-----------------------------------
-- VCS Trainer Interactions
-----------------------------------

xi.chocoboRaising.onTradeVCSTrainer = function(player, npc, trade)
    if not xi.settings.main.ENABLE_CHOCOBO_RAISING then
        player:startEvent(xi.chocoboRaising.csidTable[player:getZoneID()][1])

        return
    end

    xi.chocoboRaising.onTrade(player, npc, trade)
end

xi.chocoboRaising.onTriggerVCSTrainer = function(player, npc)
    if not xi.settings.main.ENABLE_CHOCOBO_RAISING then
        player:startEvent(xi.chocoboRaising.csidTable[player:getZoneID()][1])

        return
    end

    xi.chocoboRaising.onTrigger(player, npc)
end

xi.chocoboRaising.onEventUpdateVCSTrainer = function(player, csid, option, npc)
    if not xi.settings.main.ENABLE_CHOCOBO_RAISING then
        return
    end

    xi.chocoboRaising.eventVM(player, csid, option, npc)
end

xi.chocoboRaising.onEventFinishVCSTrainer = function(player, csid, option, npc)
    if not xi.settings.main.ENABLE_CHOCOBO_RAISING then
        return
    end

    local mainCsid   = xi.chocoboRaising.csidTable[player:getZoneID()][2]
    local tradeCsid  = xi.chocoboRaising.csidTable[player:getZoneID()][3]
    local chocoState = xi.chocoboRaising.chocoState[player:getID()]

    debug(string.format('onEventFinishVCSTrainer: csid: %i, option: %i', csid, option))

    if csid == tradeCsid and option == 252 then
        -- TODO: Validate this! Really validate this!
        --     : It has to be the same egg item as was traded at the start of the CS!
        local trade = player:getTrade()
        local egg   = trade:getItem()

        -- TODO: Make sure problems here don't leak into core and cause a crash!
        local newChoco = xi.chocoboRaising.newChocobo(player, egg)

        if player:setChocoboRaisingInfo(newChoco) then
            player:confirmTrade()
        end
    elseif csid == mainCsid then
        if chocoState == nil then
            if option == 215 then
                print('ERROR! onEventFinishVCSTrainer \'chocoState\' is nil!')
            end

            return
        end

        if chocoState.retiring then
            -- TODO: Hand over VCS registration card
            -- TODO: Hand over Color VCS plaque
            player:deleteRaisedChocobo()
            xi.chocoboRaising.chocoState[player:getID()] = nil
        else
            xi.chocoboRaising.updateChocoState(player, chocoState)
        end
    end
end
