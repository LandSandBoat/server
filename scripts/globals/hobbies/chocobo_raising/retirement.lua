-----------------------------------
-- Chocobo Raising - Retirement
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/breeding')
require('scripts/globals/hobbies/chocobo_raising/model')
require('scripts/globals/hobbies/chocobo_raising/user_data')
require('scripts/globals/hobbies/chocobo_raising/walks')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}
xi.chocoboRaising.retirement = xi.chocoboRaising.retirement or {}

-----------------------------------
-- Constants
-----------------------------------
local retirement = xi.chocoboRaising.retirement

-- Items still owed after a retirement, handed over one at a time.
retirement.heldItemsVar = '[ChocoboRaising]RetirementItems'

-----------------------------------
-- Tables
-----------------------------------
---@enum xi.chocoboRaising.retirement.heldItem
retirement.heldItem =
{
    CARD   = 0x1,
    PLAQUE = 0x2,
}

-- The hand-over event at each stable.
retirement.events =
{
    [xi.zone.SOUTHERN_SAN_DORIA] = 843,
    [xi.zone.BASTOK_MINES      ] = 518,
    [xi.zone.WINDURST_WOODS    ] = 751,
}

-----------------------------------
-- Private Functions
-----------------------------------
-- Clears the owed bit before adding the item; returns false when the inventory is full.
local function handOverItem(player, held, heldBit, itemId, exdata)
    local ID = zones[player:getZoneID()]

    if player:getFreeSlotsCount() == 0 then
        player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, itemId)
        return false
    end

    player:setCharVar(retirement.heldItemsVar, bit.band(held, bit.bnot(heldBit)))

    player:addItem({ id = itemId, exdata = exdata })
    player:messageSpecial(ID.text.ITEM_OBTAINED, itemId)

    return true
end

-----------------------------------
-- Global Functions
-----------------------------------
---@param player CBaseEntity
---@return boolean
retirement.hasHeldItems = function(player)
    return player:getCharVar(retirement.heldItemsVar) ~= 0
end

-- Gives what fits, card first, and stops at the first that does not. The chocobo stays until both are given.
---@param player CBaseEntity
---@return nil
retirement.handOver = function(player)
    local chocoState = player:getChocoboRaisingInfo()
    local held       = player:getCharVar(retirement.heldItemsVar)

    if chocoState and bit.band(held, retirement.heldItem.CARD) ~= 0 then
        if not handOverItem(player, held, retirement.heldItem.CARD, xi.item.VCS_REGISTRATION_CARD, xi.chocoboRaising.chocoStateToCard(player, chocoState)) then
            return
        end

        held = bit.band(held, bit.bnot(retirement.heldItem.CARD))
    end

    if chocoState and bit.band(held, retirement.heldItem.PLAQUE) ~= 0 then
        if not handOverItem(player, held, retirement.heldItem.PLAQUE, xi.chocoboRaising.plaques[chocoState.color]) then
            return
        end
    end

    player:setCharVar(retirement.heldItemsVar, 0)
    player:deleteRaisedChocobo()
    xi.chocoboRaising.chocoState[player:getID()] = nil
end

-- Retiring hands over a registration card and a plaque; giving up hands over nothing.
---@param player CBaseEntity
---@param chocoState table
---@param rewarded boolean
---@return nil
retirement.retire = function(player, chocoState, rewarded)
    local character = xi.chocoboRaising.characterView(player)
    xi.chocoboRaising.applyEffects(player, xi.chocoboRaising.model.cancelHandkerchief(character))

    -- A cure the next report has not shown yet is spent with this chocobo.
    if xi.chocoboRaising.handkerchiefState(player) == xi.chocoboRaising.handkerchief.RETURNED then
        xi.chocoboRaising.setHandkerchiefState(player, xi.chocoboRaising.handkerchief.DONE)
    end

    for _, keyItem in pairs(xi.chocoboRaising.walks.storyKeyItems) do
        player:delKeyItem(keyItem)
    end

    -- The diligent story leaves too, so the next chocobo gets its own lost chick. The trainer still reports a result.
    local chick = xi.chocoboRaising.walks.lostChick(player:getCharVar(xi.chocoboRaising.walks.lostChickVar))
    local kept  =
    {
        owner        = 0,
        clues        = 0,
        location     = 0,
        trainerClues = {},
        result       = chick.result,
        solved       = false,
    }

    player:setCharVar(xi.chocoboRaising.walks.lostChickVar, xi.chocoboRaising.walks.packLostChick(kept))

    if rewarded and not retirement.hasHeldItems(player) then
        chocoState.stage = xi.chocoboRaising.stage.ADULT_4
        xi.chocoboRaising.updateChocoState(player, chocoState)
        player:setCharVar(retirement.heldItemsVar, retirement.heldItem.CARD + retirement.heldItem.PLAQUE)
    end

    retirement.handOver(player)
end

---@param player CBaseEntity
---@return nil
retirement.startHandOverEvent = function(player)
    local zoneID   = player:getZoneID()
    local location = xi.chocoboRaising.raisingLocation[zoneID]

    player:startEvent(retirement.events[zoneID], xi.chocoboRaising.stage.ADULT_4, 0, 0, 0, 0, 0, 3, location)
end

---@param player CBaseEntity
---@param csid integer
---@return boolean
retirement.onEventFinish = function(player, csid)
    if csid ~= retirement.events[player:getZoneID()] then
        return false
    end

    -- A trade that started this event is handed back; nothing in it was confirmed.
    if player:getTrade():getItemCount() > 0 then
        player:confirmTrade()
    end

    retirement.handOver(player)

    return true
end
