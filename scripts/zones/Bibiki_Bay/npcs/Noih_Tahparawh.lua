-----------------------------------
-- Area: Bibiki Bay
--  NPC: Noih Tahparawh
-- Type: Manaclipper Timekeeper
-- !pos -392 -3 -385 4
-----------------------------------
local ID = zones[xi.zone.BIBIKI_BAY]
-----------------------------------
---@type TNpcEntity
local entity = {}

local announcements =
{
    { offset =  520, text = ID.text.MANACLIPPER_ISLE_ARRIVED },
    { offset =  555, text = ID.text.MANACLIPPER_ISLE_DEPARTING },
}

local timekeeperLocation = xi.manaclipper.location.PURGONORGO_ISLE
local timekeeperEventId = 19

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
