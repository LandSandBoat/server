-----------------------------------
-- Chocobo Raising - VCS Trainers
-- Dedicated to 'Friend' the Chocobo. RIP.
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/choco_data')
require('scripts/globals/hobbies/chocobo_raising/condense_events')
require('scripts/globals/hobbies/chocobo_raising/constants')
require('scripts/globals/hobbies/chocobo_raising/debug_vm')
require('scripts/globals/hobbies/chocobo_raising/event_playout')
require('scripts/globals/hobbies/chocobo_raising/event_vm')
require('scripts/globals/hobbies/chocobo_raising/names')
require('scripts/globals/hobbies/chocobo_raising/retirement')
require('scripts/globals/hobbies/chocobo_raising/whistle')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}
xi.chocoboRaising.chocoState = xi.chocoboRaising.chocoState or {}

-----------------------------------
-- Constants
-----------------------------------
local debug = utils.getDebugPlayerPrinter(xi.settings.main.DEBUG_CHOCOBO_RAISING)

-----------------------------------
-- Global Functions
-----------------------------------
---@param player CBaseEntity
---@param npc CBaseEntity
---@param trade CTradeContainer
xi.chocoboRaising.onTradeVCSTrainer = function(player, npc, trade)
    if not xi.settings.main.ENABLE_CHOCOBO_RAISING then
        player:startEvent(xi.chocoboRaising.csidTable[player:getZoneID()][1])
        return
    end

    if xi.chocoboRaising.whistle.onTrade(player, npc, trade) then
        return
    end

    if xi.chocoboRaising.retirement.hasHeldItems(player) then
        xi.chocoboRaising.retirement.startHandOverEvent(player)
        return
    end

    xi.chocoboRaising.onTrade(player, npc, trade)
end

---@param player CBaseEntity
---@param npc CBaseEntity
xi.chocoboRaising.onTriggerVCSTrainer = function(player, npc)
    if not xi.settings.main.ENABLE_CHOCOBO_RAISING then
        player:startEvent(xi.chocoboRaising.csidTable[player:getZoneID()][1])
        return
    end

    if xi.chocoboRaising.retirement.hasHeldItems(player) then
        xi.chocoboRaising.retirement.startHandOverEvent(player)
        return
    end

    xi.chocoboRaising.onTrigger(player, npc)
end

---@param player CBaseEntity
---@param csid integer
---@param option integer
---@param npc CBaseEntity
xi.chocoboRaising.onEventUpdateVCSTrainer = function(player, csid, option, npc)
    if not xi.settings.main.ENABLE_CHOCOBO_RAISING then
        return
    end

    if xi.chocoboRaising.whistle.onEventUpdate(player, csid, option) then
        return
    end

    xi.chocoboRaising.eventVM(player, csid, option, npc)
end

---@param player CBaseEntity
---@param csid integer
---@param option integer
---@param npc CBaseEntity?
xi.chocoboRaising.onEventFinishVCSTrainer = function(player, csid, option, npc)
    if not xi.settings.main.ENABLE_CHOCOBO_RAISING then
        return
    end

    if
        xi.chocoboRaising.whistle.onEventFinish(player, csid, option) or
        xi.chocoboRaising.retirement.onEventFinish(player, csid)
    then
        return
    end

    local csids     = xi.chocoboRaising.csidTable[player:getZoneID()]
    local mainCSID  = csids[2]
    local tradeCSID = csids[3]

    debug(string.format('onEventFinishVCSTrainer: csid: %i, option: %i', csid, option))

    if csid == tradeCSID and option == 252 then
        local tradedEgg = player:getLocalVar(xi.chocoboRaising.tradedEggVar)
        player:setLocalVar(xi.chocoboRaising.tradedEggVar, 0)

        local trade = player:getTrade()
        if not trade then
            return
        end

        local egg = trade:getItem()
        if
            not egg or
            egg:getID() ~= tradedEgg
        then
            return
        end

        -- TODO: Keep errors here from crashing the core.
        local newChoco = xi.chocoboRaising.newChocobo(player, egg)

        if player:setChocoboRaisingInfo(newChoco) then
            -- The egg must be taken, or the chocobo is not kept.
            if not player:confirmTrade() then
                player:deleteRaisedChocobo()
                xi.chocoboRaising.chocoState[player:getID()] = nil
                return
            end

            xi.chocoboRaising.addChocoboRaised(player)
        end
    elseif csid == mainCSID then
        local chocoState = xi.chocoboRaising.chocoState[player:getID()]
        if not chocoState then
            if option == 215 then
                print('ERROR! onEventFinishVCSTrainer \'chocoState\' is nil!')
            end

            return
        end

        -- Request documentation: a chococard.
        if option == xi.chocoboRaising.documentChococard then
            xi.chocoboRaising.issueChococard(player, chocoState)
        end

        if option == xi.chocoboRaising.whistle.option.BUY_WHISTLE then
            xi.chocoboRaising.whistle.buyWhistle(player)
        elseif option == xi.chocoboRaising.whistle.option.RECEIVE_WHISTLE then
            xi.chocoboRaising.whistle.receiveWhistle(player)
        end

        if chocoState.retiring then
            xi.chocoboRaising.retirement.retire(player, chocoState, chocoState.rewardCard == true)
        else
            xi.chocoboRaising.updateChocoState(player, chocoState)
        end
    end
end
