-----------------------------------
-- Zone: Batallia_Downs (105)
-----------------------------------
local ID = require('scripts/zones/Batallia_Downs/IDs')
require('scripts/quests/full_speed_ahead')
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/globals/chocobo_digging')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

local function registerRegionAroundNPC(zone, NPCID, zoneID)
    local npc      = GetNPCByID(NPCID)
    local x        = npc:getXPos()
    local y        = npc:getYPos()
    local z        = npc:getZPos()
    local distance = 7

    zone:registerTriggerArea(zoneID,
        x - distance, y - distance, z - distance,
        x + distance, y + distance, z + distance)
end

zoneObject.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.AHTU)
    GetMobByID(ID.mob.AHTU):setRespawnTime(math.random(900, 10800))

    for i = 0, 7 do
        registerRegionAroundNPC(zone, ID.npc.RAPTOR_FOOD_BASE + i, i + 1)
    end

    registerRegionAroundNPC(zone, ID.npc.SYRILLIA, 9)

    xi.voidwalker.zoneOnInit(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(457, 8, -156, 142)
    end

    if player:getCharVar("[QUEST]FullSpeedAhead") == 1 then -- Normal Mode
        player:addStatusEffect(xi.effect.FULL_SPEED_AHEAD, 0, 3, xi.fsa.duration)
        return -1
    elseif player:getCharVar("[QUEST]FullSpeedAhead") == 2 then -- Easy Mode
        player:addStatusEffect(xi.effect.FULL_SPEED_AHEAD, 1, 3, xi.fsa.duration)
        return -1
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 901
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    if player:hasStatusEffect(xi.effect.FULL_SPEED_AHEAD) then
        xi.fsa.onTriggerAreaEnter(player, triggerArea:GetTriggerAreaID())
    end
end

zoneObject.onEventUpdate = function(player, csid, option)
    if csid == 901 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 24 then
        xi.fsa.completeGame(player)
    elseif
        csid == 26 and
        option == 0
    then
        player:setCharVar("[QUEST]FullSpeedAhead", 1)
        player:setPos(475, 8.8, -159, 128, 105)
    elseif
        csid == 26 and
        option == 1
    then
        player:setCharVar("[QUEST]FullSpeedAhead", 2)
        player:setPos(475, 8.8, -159, 128, 105)
    end
end

return zoneObject
