-----------------------------------
--
-- Zone: Zeruhn_Mines (172)
--
-----------------------------------
local ID = require("scripts/zones/Zeruhn_Mines/IDs")
require("scripts/globals/conquest")
require("scripts/globals/quests")
require("scripts/globals/helm")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
    tpz.helm.initZone(zone, tpz.helm.type.MINING)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if prevZone == tpz.zone.PALBOROUGH_MINES then
        cs = 150
        if player:getQuestStatus(BASTOK, tpz.quest.id.bastok.BLADE_OF_DARKNESS) == QUEST_ACCEPTED then
            if player:getCharVar("ZeruhnMines_Zeid_CS") == 0 then
                cs = 130
            elseif not player:hasItem(16607) then
                cs = 131
            end
        elseif player:getQuestStatus(BASTOK, tpz.quest.id.bastok.BLADE_OF_DEATH) == QUEST_ACCEPTED then
            if not player:hasItem(16607) then
                cs = 131
            end
        end
    elseif player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-270.707, 14.159, -20.268, 0)
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 130 or csid == 131 then
        if player:getFreeSlotsCount() > 0 then
            player:addItem(16607)
            player:setCharVar("ChaosbringerKills", 0)
            player:messageSpecial(ID.text.ITEM_OBTAINED, 16607)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, 16607)
        end
        player:setCharVar("ZeruhnMines_Zeid_CS", 1)
    end
end
