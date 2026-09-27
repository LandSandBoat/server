-----------------------------------
-- Chocobo Raising - Event Playout
-----------------------------------
require('scripts/globals/hobbies/chocobo_raising/care_plan')
require('scripts/globals/hobbies/chocobo_raising/constants')
require('scripts/globals/hobbies/chocobo_raising/whistle')
-----------------------------------
xi = xi or {}
xi.chocoboRaising = xi.chocoboRaising or {}

-----------------------------------
-- Constants
-----------------------------------
local debug = utils.getDebugPlayerPrinter(xi.settings.main.DEBUG_CHOCOBO_RAISING)

-- The egg handed in, checked again when the hatching event finishes.
xi.chocoboRaising.tradedEggVar = '[ChocoboRaising]TradedEgg'

-----------------------------------
-- Helpers
-----------------------------------
local function tradeHasWakingFood(trade)
    for slotId = 0, 7 do
        local item = trade:getItem(slotId)
        local food = item and xi.chocoboRaising.validFoods[item:getID()]

        if food and food.wakes then
            return true
        end
    end

    return false
end

-----------------------------------
-- Private Functions
-----------------------------------
-- Report cutscenes change nothing here; the day model applied those days at rollover.
local playoutHandlers =
{
    [xi.chocoboRaising.cutscenes.HANGS_HEAD_IN_SHAME] = function(player, chocoState)
        -- TODO: Affection loss amount. Energy is charged by the care action.
        chocoState.affection = xi.chocoboRaising.handleStatChange(xi.chocoboRaising.carePlanStats.AFFECTION, chocoState.affection, -10, 255)
        xi.chocoboRaising.setCondition(chocoState, xi.chocoboRaising.conditions.SPOILED, false)
    end,

    [xi.chocoboRaising.cutscenes.COMPETE_WITH_OTHERS] = function(player, chocoState)
        -- Energy is charged by the care action.
        chocoState.affection = xi.chocoboRaising.handleStatChange(xi.chocoboRaising.carePlanStats.AFFECTION, chocoState.affection, 1, 255)
        xi.chocoboRaising.addPendingCure(chocoState, xi.chocoboRaising.conditions.BORED)
    end,
}

-----------------------------------
-- Global Functions
-----------------------------------
---@param player CBaseEntity
---@param npc CBaseEntity
---@param trade CTradeContainer
xi.chocoboRaising.onTrade = function(player, npc, trade)
    local zoneID        = player:getZoneID()
    local ID            = zones[zoneID]
    local csids         = xi.chocoboRaising.csidTable[zoneID]
    local mainCSID      = csids[2]
    local tradeCSID     = csids[3]
    local rejectionCSID = csids[4]
    local location      = xi.chocoboRaising.raisingLocation[zoneID]
    local saved         = player:getChocoboRaisingInfo()

    if
        npcUtil.tradeHasExactly(trade, xi.item.CHOCOBO_EGG_FAINTLY_WARM) or
        npcUtil.tradeHasExactly(trade, xi.item.CHOCOBO_EGG_SLIGHTLY_WARM) or
        npcUtil.tradeHasExactly(trade, xi.item.CHOCOBO_EGG_A_BIT_WARM) or
        npcUtil.tradeHasExactly(trade, xi.item.CHOCOBO_EGG_A_LITTLE_WARM) or
        npcUtil.tradeHasExactly(trade, xi.item.CHOCOBO_EGG_SOMEWHAT_WARM)
    then
        if not saved then
            -- The egg is taken in onEventFinish and xi.chocoboRaising.newChocobo.
            player:setLocalVar(xi.chocoboRaising.tradedEggVar, trade:getItem():getID())
            player:startEvent(tradeCSID, VanadielTime(), 0, 0, 0, 0, 0, 0, location)
        else
            -- A chocobo is already raised. p0 is its stable, p7 this one; the client picks "another nation's stables" when they differ.
            player:startEvent(rejectionCSID, saved.location, 0, 0, 0, 0, 0, 0, location)
        end

        return
    end

    if not saved then
        return
    end

    if saved.location ~= location then
        player:startEvent(csids[1], 1, 1, 1, 1)
        return
    end

    local chocoState = xi.chocoboRaising.initChocoState(player, saved)
    if not chocoState then
        return
    end

    if chocoState.stage == xi.chocoboRaising.stage.EGG then
        player:showText(npc, ID.text.CHOCOBO_FEEDING_STILL_EGG)
        return
    end

    if
        not tradeHasWakingFood(trade) and
        xi.chocoboRaising.getCondition(chocoState, xi.chocoboRaising.conditions.SLEEPING)
    then
        player:showText(npc, ID.text.CHOCOBO_FEEDING_SLEEP)
        return
    end

    if xi.chocoboRaising.getCondition(chocoState, xi.chocoboRaising.conditions.RUN_AWAY) then
        player:showText(npc, ID.text.CHOCOBO_FEEDING_RUN_AWAY)
        return
    end

    -- At most 4, cures then chocolixirs, stat items and food; a chocotonic alone; non-food is left.
    local maxItemsEaten = 4
    local offered       = {}

    for slotId = 0, 7 do
        local item = trade:getItem(slotId)

        if item and xi.chocoboRaising.validFoods[item:getID()] then
            local id = item:getID()

            for _ = 1, trade:getSlotQty(slotId) do
                table.insert(offered, { id = id, order = #offered })
            end
        end
    end

    table.sort(offered, function(left, right)
        local leftCategory  = xi.chocoboRaising.validFoods[left.id].category
        local rightCategory = xi.chocoboRaising.validFoods[right.id].category

        if leftCategory ~= rightCategory then
            return leftCategory < rightCategory
        end

        return left.order < right.order
    end)

    local tradedItems = {}
    for _, entry in ipairs(offered) do
        if xi.chocoboRaising.validFoods[entry.id].alone then
            tradedItems = { entry.id }
            break
        end

        if #tradedItems < maxItemsEaten then
            table.insert(tradedItems, entry.id)
        end
    end

    local eaten = {}
    for _, id in ipairs(tradedItems) do
        eaten[id] = (eaten[id] or 0) + 1
    end

    for id, quantity in pairs(eaten) do
        trade:confirmItem(id, quantity)
    end

    chocoState.foodGiven = tradedItems

    if #tradedItems == 0 then
        return
    end

    -- p0 is the item for a single item, 10 for a mixed trade; p7 the number of items.
    local shown = 10
    if #tradedItems == 1 then
        shown = tradedItems[1]
    end

    -- 1 opens with the report greeting.
    local infoFlag = 0
    if #chocoState.report.events > 0 then
        infoFlag = 1
    end

    xi.chocoboRaising.chocoState[player:getID()] = chocoState

    local fullName, firstName, lastName = xi.chocoboRaising.nameStrings(chocoState)
    player:startEventString(mainCSID, fullName, firstName, lastName, '', shown, infoFlag, chocoState.sex, 0, 0, 0, 0, #tradedItems)
end

---@param player CBaseEntity
---@param npc CBaseEntity
xi.chocoboRaising.onTrigger = function(player, npc)
    local zoneID       = player:getZoneID()
    local csids        = xi.chocoboRaising.csidTable[zoneID]
    local reminderCSID = csids[1]
    local mainCSID     = csids[2]
    local saved        = player:getChocoboRaisingInfo()

    if not saved then
        player:startEvent(reminderCSID, 1)
        return
    end

    if saved.location ~= xi.chocoboRaising.raisingLocation[zoneID] then
        player:startEvent(reminderCSID, 1, 1, 1, 1)
        return
    end

    local chocoState = xi.chocoboRaising.initChocoState(player, saved)
    if not chocoState then
        return
    end

    -- 1 opens with the report greeting.
    local infoFlag = 0
    if #chocoState.report.events > 0 then
        infoFlag = 1
    end

    xi.chocoboRaising.chocoState[player:getID()] = chocoState

    local fullName, firstName, lastName = xi.chocoboRaising.nameStrings(chocoState)
    player:startEventString(mainCSID, fullName, firstName, lastName, '', 0, infoFlag, chocoState.sex, 0, 0, 0, 0, chocoState.location)
end

-- csList entries are { cutscene, days in the record, cutscenes in the record }.
---@param player CBaseEntity
---@param chocoState ChocoboState
xi.chocoboRaising.handleCSUpdate = function(player, chocoState)
    local entry    = table.remove(chocoState.csList, 1)
    local csOffset = entry[1]

    -- Scene id is location * 256 plus the cutscene offset.
    local csToPlay = xi.chocoboRaising.raisingLocation[player:getZoneID()] * 256 + csOffset

    debug(string.format('Playing CS: %d (%d)', csToPlay, csOffset))

    -- A growth scene and the rest of its record show the new stage.
    for _, boundary in ipairs(xi.chocoboRaising.ageBoundaries()) do
        if boundary[3] == csOffset then
            chocoState.reportStage = boundary[4]
        end
    end

    -- p2 = 1 makes the adult scene mention the open whistle quest.
    local whistleProg      = xi.chocoboRaising.whistleProgress(player)
    local whistleQuestOpen = csOffset == xi.chocoboRaising.cutscenes.ADOLESCENT_TO_ADULT_1 and
        whistleProg >= 1 and
        whistleProg < xi.chocoboRaising.whistleProg.DONE and 1 or 0

    local fullName, firstName, lastName = xi.chocoboRaising.nameStrings(chocoState)
    player:updateEventString(fullName, firstName, lastName, lastName, 0, 0, 0, 0, 0, 0, 0, 0)

    -- TODO: p6 is a byte that changes on egg days (255, 250, 245, 240); p7 looks like the weather.
    player:updateEvent(#chocoState.csList, csToPlay, whistleQuestOpen, entry[3], chocoState.reportStage or chocoState.stage, 0, 0, 3)
end

---@param player CBaseEntity
---@param csOffset integer
---@param chocoState ChocoboState
xi.chocoboRaising.onRaisingEventPlayout = function(player, csOffset, chocoState)
    local handler = playoutHandlers[csOffset]
    if handler then
        handler(player, chocoState)
    end

    xi.chocoboRaising.updateChocoState(player, chocoState)
end
