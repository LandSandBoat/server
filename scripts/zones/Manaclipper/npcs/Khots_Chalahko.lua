-----------------------------------
-- Area: Manaclipper
--  NPC: Khots Chalahko
-- Type: Tour Guide
-----------------------------------
local ID = zones[xi.zone.MANACLIPPER]
-----------------------------------
---@type TNpcEntity
local entity = {}

-- 6 lines per trip at fixed intervals
local tours =
{
    { period = 1440, text = ID.text.TOUR_DHALMEL_ROCK_OFFSET,      at = {  71,  80, 109, 188, 230, 264 } },
    { period = 1440, text = ID.text.TOUR_MALIYAKALEYA_REEF_OFFSET, at = { 792, 815, 853, 871, 932, 984 } },
    { period =  720, text = ID.text.TOUR_PURGONORGO_ISLE_OFFSET,   at = { 349, 360, 412, 453, 470, 482 } },
    { period =  720, text = ID.text.TOUR_SUNSET_DOCKS_OFFSET,      at = { 565, 595, 618, 657, 692, 698 } },
}

local linesPerTour = 6

entity.onSpawn = function(npc)
    for tourIndex, tour in ipairs(tours) do
        for line, offset in ipairs(tour.at) do
            npc:addPeriodicTrigger((tourIndex - 1) * linesPerTour + line - 1, tour.period, offset)
        end
    end
end

entity.onTimeTrigger = function(npc, triggerID)
    local tour = tours[math.floor(triggerID / linesPerTour) + 1]

    npc:showText(npc, tour.text + triggerID % linesPerTour)
end

return entity
