-----------------------------------
-- Zone: Altar_Room (152)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1
    local head = player:getEquipID(xi.slot.HEAD)

    if
        player:getCharVar('FickblixCS') == 1 and
        player:getNation() ~= xi.nation.SANDORIA
    then
        cs = 10000
    elseif
        player:getQuestStatus(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.A_MORAL_MANIFEST) == xi.questStatus.QUEST_AVAILABLE and
        player:getMainLvl() >= 60 and
        player:getCharVar('moraldecline') == 0
    then
        cs = 46
    elseif player:getCharVar('moral') == 4 and head == 15202 then -- Yagudo Headgear
        cs = 47
    elseif player:getCharVar('moral') == 8 and head == 15216 then -- Tsoo Headgear
        cs = 51
    end

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-247.998, 12.609, -100.008, 128)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 10000 then
        player:setCharVar('FickblixCS', 0)
    elseif csid == 46 and option == 0 then
        player:setCharVar('moral', 1)
        player:addQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.A_MORAL_MANIFEST)
    elseif csid == 46 and option == 1 then
        player:setCharVar('moraldecline', 1, NextConquestTally())
    elseif csid == 47 then
        npcUtil.giveKeyItem(player, xi.ki.VAULT_QUIPUS)
        player:setCharVar('moral', 5)
    elseif csid == 51 then
        player:setCharVar('moralrebuy', 1)
        npcUtil.completeQuest(player, xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.A_MORAL_MANIFEST, {
            item = 748,
            var = 'moral'
        })
    end
end

return zoneObject
