-----------------------------------
-- Zone: North_Gustaberg_[S] (88)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    local olgoikhorkhoi = zone:queryEntitiesByName('Olgoi-Khorkhoi')[1]
    -- UpdatSpawnPoint(OLGOI_KHORKHOI:getID()) TODO: need rows in nm_spawn_points.sql
    olgoikhorkhoi:setRespawnTime(math.random(3600, 5400))

    xi.helm.initZone(zone, xi.helmType.MINING)
    xi.voidwalker.zoneOnInit(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(380.038, -2.25, 147.627, 192)
    end

    if
        prevZone == xi.zone.BASTOK_MARKETS_S and
        player:getCampaignAllegiance() > 0 and
        player:getQuestStatus(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.BETTER_PART_OF_VALOR) == xi.questStatus.QUEST_AVAILABLE
    then
        cs = 1
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 1 then
        player:addQuest(xi.questLog.CRYSTAL_WAR, xi.quest.id.crystalWar.BETTER_PART_OF_VALOR)
        npcUtil.giveKeyItem(player, xi.ki.CLUMP_OF_ANIMAL_HAIR)
    end
end

return zoneObject
