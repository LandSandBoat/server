-----------------------------------
-- Era Override: Ro'Meave Moongate Time
-- Opens only on Full Moon between 00:00 and 03:00
--
-- Source: https://ffxiclopedia.fandom.com/wiki/Moongate_Pass_Quest?oldid=1493013
-- Moongate Pass Quest did not change to 18:00 - 06:00 until the July 13, 2011 version update.
-----------------------------------
require('modules/module_utils')
require('scripts/globals/npc_util')
xi.module.ensureTable('xi.zones.RoMaeve')
-----------------------------------
local ID = zones[xi.zone.ROMAEVE]
-----------------------------------
local m = Module:new('era_moongate_time')

local function activateRoMaeve(zone)
    local validMoon    = (getVanadielMoonCycle() == xi.moonCycle.FULL_MOON)
    local validHour    = (VanadielHour() >= 0 and VanadielHour() < 3)
    local validWeather = (zone:getWeather() == xi.weather.NONE or zone:getWeather() == xi.weather.SUNSHINE)

    local shouldDoorsOpen        = (validMoon and validHour)
    local shouldFountainActivate = (validMoon and validHour and validWeather)

    local moongate1 = GetNPCByID(ID.npc.MOONGATE_OFFSET)
    if moongate1 then
        moongate1:setUntargetable(shouldDoorsOpen)
    end

    local moongate2 = GetNPCByID(ID.npc.MOONGATE_OFFSET + 1)
    if moongate2 then
        moongate2:setUntargetable(shouldDoorsOpen)
    end

    -- Determine what the animation/status of the NPCs should be.
    local doorStatus     = shouldDoorsOpen and xi.anim.OPEN_DOOR or xi.anim.CLOSE_DOOR
    local fountainStatus = shouldFountainActivate and xi.anim.OPEN_DOOR or xi.anim.CLOSE_DOOR

    -- Loop over the affected NPCs: Moongates, bridges and fountain
    for i = ID.npc.MOONGATE_OFFSET, ID.npc.MOONGATE_OFFSET + 7 do
        local npc = GetNPCByID(i)
        if i == ID.npc.MOONGATE_OFFSET + 6 then -- Fountain
            if npc and npc:getAnimation() ~= fountainStatus then
                npc:setAnimation(fountainStatus)
            end
        else
            if npc and npc:getAnimation() ~= doorStatus then
                npc:setAnimation(doorStatus)
            end
        end
    end
end

m:addOverride('xi.zones.RoMaeve.Zone.onInitialize', function(zone)
    super(zone)
    activateRoMaeve(zone)
end)

m:addOverride('xi.zones.RoMaeve.Zone.onGameHour', function(zone)
    super(zone)
    activateRoMaeve(zone)
end)

return m
