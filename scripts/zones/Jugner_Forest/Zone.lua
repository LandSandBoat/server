-----------------------------------
-- Zone: Jugner_Forest (104)
-----------------------------------
local ID = require('scripts/zones/Jugner_Forest/IDs')
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/globals/chocobo_digging')
require('scripts/globals/conquest')
require('scripts/globals/helm')
require('scripts/globals/zone')
require('scripts/missions/amk/helpers')
-----------------------------------
local zoneObject = {}

zoneObject.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zoneObject.onInitialize = function(zone)
    -- NM Persistence
    xi.mob.nmTODPersistCache(zone, ID.mob.METEORMAULER)
    xi.mob.nmTODPersistCache(zone, ID.mob.FRAELISSA)
    for offset = 1, 10 do
        xi.mob.nmTODPersistCache(zone, ID.mob.KING_ARTHRO - offset)
    end

    -- Triger Areas
    zone:registerTriggerArea(1, -484, 10, 292, 0, 0, 0) -- Sets Mark for "Under Oath" Quest cutscene.

    -- CONQUEST
    xi.conq.setRegionalConquestOverseers(zone:getRegionID())

    -- HELM
    xi.helm.initZone(zone, xi.helm.type.LOGGING)

    -- VOIDWALKER
    xi.voidwalker.zoneOnInit(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-594, -7, -442, 253)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 15
    end

    -- AMK06/AMK07
    if xi.settings.main.ENABLE_AMK == 1 then
        xi.amk.helpers.tryRandomlyPlaceDiggingLocation(player)
    end

    return cs
end

zoneObject.onZoneOut = function(player)
    if player:hasStatusEffect(xi.effect.BATTLEFIELD) then
        player:delStatusEffect(xi.effect.BATTLEFIELD)
    end
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onGameDay = function()
    SetServerVariable("[DIG]ZONE104_ITEMS", 0)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    if
        triggerArea:GetTriggerAreaID() == 1 and
        player:getVar("Quest[0][92]Prog") == 7
    then
        -- Quest: Under Oath - PLD AF3
        player:startEvent(14)
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    if csid == 15 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 14 then
        player:setCharVar("Quest[0][92]Prog", 8) -- Quest: Under Oath - PLD AF3
    end
end

return zoneObject
