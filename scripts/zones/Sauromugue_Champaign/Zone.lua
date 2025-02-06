-----------------------------------
-- Zone: Sauromugue_Champaign (120)
-----------------------------------
local ID = zones[xi.zone.SAUROMUGUE_CHAMPAIGN]
require('scripts/quests/i_can_hear_a_rainbow')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- A Chocobo Riding Game finish line
    zone:registerCylindricalTriggerArea(1, -489.11, 349.14, 20)

    UpdateNMSpawnPoint(ID.mob.ROC)
    GetMobByID(ID.mob.ROC):setRespawnTime(math.random(900, 10800))
    GetNPCByID(ID.npc.QM2 + math.random(0, 5)):setLocalVar('Quest[2][70]Option', 1) -- Determine which QM is active today for THF AF2
    xi.voidwalker.zoneOnInit(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-571, 1, 339, 7)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 3
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
    xi.chocoboGame.handleMessage(player)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    local triggerAreaID = triggerArea:getTriggerAreaID()

    if triggerAreaID == 1 and player:hasStatusEffect(xi.effect.MOUNTED) then
        xi.chocoboGame.onTriggerAreaEnter(player)
    end
end

zoneObject.onGameDay = function()
    for i = ID.npc.QM2, ID.npc.QM2 + 5 do
        GetNPCByID(i):resetLocalVars()
    end

    GetNPCByID(ID.npc.QM2 + math.random(0, 5)):setLocalVar('Quest[2][70]Option', 1) -- Determine which QM is active today for THF AF2
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    if csid == 3 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    xi.chocoboGame.onEventFinish(player, csid)
end

return zoneObject
