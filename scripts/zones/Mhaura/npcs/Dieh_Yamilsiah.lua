-----------------------------------
-- Area: Mhaura
--  NPC: Dieh Yamilsiah
-- Reports the time remaining before boat arrival.
-- !pos 7.057 -2.364 2.489 249
-----------------------------------
local ID = zones[xi.zone.MHAURA]
-----------------------------------
local entity = {}

local messages =
{
    [xi.transport.trigger.mhaura.FERRY_ARRIVING_FROM_ALZAHBI] = ID.text.FERRY_ARRIVING,
    [xi.transport.trigger.mhaura.FERRY_DEPARTING_TO_ALZAHBI]  = ID.text.FERRY_DEPARTING,
    [xi.transport.trigger.mhaura.FERRY_ARRIVING_FROM_SELBINA] = ID.text.FERRY_ARRIVING,
    [xi.transport.trigger.mhaura.FERRY_DEPARTING_TO_SELBINA]  = ID.text.FERRY_DEPARTING
}

entity.onSpawn = function(npc)
    npc:initNpcAi()
    -- TODO: NPC needs to rotate after finishing walking.
    npc:addPeriodicTrigger(xi.transport.trigger.mhaura.FERRY_ARRIVING_FROM_ALZAHBI,
        xi.transport.interval.mhaura.FROM_TO_ALZAHBI,
        xi.transport.offset.mhaura.FERRY_ARRIVING_FROM_ALZAHBI)
    npc:addPeriodicTrigger(xi.transport.trigger.mhaura.FERRY_DEPARTING_TO_ALZAHBI,
        xi.transport.interval.mhaura.FROM_TO_ALZAHBI,
        xi.transport.offset.mhaura.FERRY_DEPARTING_TO_ALZAHBI)
    npc:addPeriodicTrigger(xi.transport.trigger.mhaura.FERRY_ARRIVING_FROM_SELBINA,
        xi.transport.interval.mhaura.FROM_TO_SELBINA,
        xi.transport.offset.mhaura.FERRY_ARRIVING_FROM_SELBINA)
    npc:addPeriodicTrigger(xi.transport.trigger.mhaura.FERRY_DEPARTING_TO_SELBINA,
        xi.transport.interval.mhaura.FROM_TO_SELBINA,
        xi.transport.offset.mhaura.FERRY_DEPARTING_TO_SELBINA)
end

entity.onTimeTrigger = function(npc, triggerID)
    xi.transport.dockMessage(npc, triggerID, messages, 'mhaura')
end

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Each boat comes every 1152 seconds/8 game hours, 4 hour offset between Selbina and Aht Urghan
    -- Original timer: local timer = 1152 - ((os.time() - 1009810584)%1152)
    local timer = 1152 - ((os.time() - 1009810802)%1152)
    local destination = 0 -- Selbina, set to 1 for Al Zhabi
    local direction = 0 -- Arrive, 1 for depart
    local waiting = 216 -- Offset for Selbina

    -- Next ferry is Al Zhabi for higher values.
    if timer >= 576 then
        destination = 1
        timer = timer - 576
        waiting = 193
    end

    -- Logic to manipulate cutscene results.
    if timer <= waiting then
        direction = 1 -- Ship arrived, switch dialog from "arrive" to "depart"
    else
        timer = timer - waiting -- Ship hasn't arrived, subtract waiting time to get time to arrival
    end

    player:startEvent(231, timer, direction, 0, destination) -- timer arriving/departing ??? destination

    --[[Other cutscenes:
    233 "This ship is headed for Selbina."
    234 "The Selbina ferry will deparrrt soon!  Passengers are to board the ship immediately!"

    Can't find a way to toggle the destination on 233 or 234, so they are not used.
    Users knowing which ferry is which > using all CSs.]]
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
