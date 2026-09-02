-----------------------------------
-- Area: Bibiki Bay
--  NPC: Fheli Lapatzuo
-- Type: Manaclipper Timekeeper
-- !pos 488.793 -4.003 709.473 4
-----------------------------------
local ID = zones[xi.zone.BIBIKI_BAY]
-----------------------------------
---@type TNpcEntity
local entity = {}

local announcements =
{
    { offset =   10, text = ID.text.MANACLIPPER_ARRIVED },
    { offset =   50, text = ID.text.MANACLIPPER_DEPARTING },
    { offset =  290, text = ID.text.MANACLIPPER_ARRIVED },
    { offset =  330, text = ID.text.MANACLIPPER_DEPARTING },
}

local timekeeperLocation = xi.manaclipper.location.SUNSET_DOCKS
local timekeeperEventId = 18

entity.onSpawn = function(npc)
    for id, announcement in ipairs(announcements) do
        npc:addPeriodicTrigger(id - 1, 720, announcement.offset)
    end
end

entity.onTimeTrigger = function(npc, triggerID)
    npc:showText(npc, announcements[triggerID + 1].text)
end

entity.onTrigger = function(player, npc)
    xi.manaclipper.timekeeperOnTrigger(player, timekeeperLocation, timekeeperEventId)
end

return entity
